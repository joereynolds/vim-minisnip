function! minisnip#ShouldTrigger()
    silent! unlet! s:snippetfile
    let l:cword = matchstr(getline('.'), '\v\f+%' . col('.') . 'c')

    " look for a snippet by that name
    for l:dir in split(g:minisnip_dir, ':')
        let l:snippetfile = l:dir . '/' . l:cword
        let l:ft_snippetfile = l:dir . '/_' . &filetype . '_' . l:cword
        if filereadable(l:ft_snippetfile)
            " filetype snippets override general snippets
            let l:snippetfile = l:ft_snippetfile
        endif

        " make sure the snippet exists
        if filereadable(l:snippetfile)
            let s:snippetfile = l:snippetfile
            return 1
        endif
    endfor

    return search(g:minisnip_delimpat, 'e')
endfunction

" main function, called on press of Tab (or whatever key Minisnip is bound to)
function! minisnip#Minisnip()
    if exists("s:snippetfile")
        " reset placeholder text history (for backrefs)
        let s:placeholder_texts = []
        let s:placeholder_text = ''
        " remove the snippet name
        normal! "_diw
        " adjust the indentation, use the current line as reference
        let ws = matchstr(getline(line('.')), '^\s\+')
        let lns = map(readfile(s:snippetfile), 'empty(v:val)? v:val : ws.v:val')
        " insert the snippet
        call append(line('.'), lns)
        " remove the empty line before the snippet
        normal! J
        " select the first placeholder
        call s:SelectPlaceholder()
    else
        " save the current placeholder's text so we can backref it
        let l:old_s = @s
        normal! ms"syv`<`s
        let s:placeholder_text = @s
        let @s = l:old_s
        " jump to the next placeholder
        call s:SelectPlaceholder()
    endif
endfunction

" this is the function that finds and selects the next placeholder
function! s:SelectPlaceholder()
    " don't clobber s register
    let l:old_s = @s

    " get the contents of the placeholder
    " we use /e here in case the cursor is already on it (which occurs ex.
    "   when a snippet begins with a placeholder)
    " we also use keeppatterns to avoid clobbering the search history /
    "   highlighting all the other placeholders
    try
        " gn misbehaves when 'wrapscan' isn't set (see vim's #1683)
        let [l:ws, &ws] = [&ws, 1]
        silent keeppatterns execute 'normal! /' . g:minisnip_delimpat . "/e\<cr>gn\"sy"
    catch /E486:/
        " There's no placeholder at all, enter insert mode
        call feedkeys('i', 'n')
        return
    finally
        let &ws = l:ws
    endtry

    " save the contents of the previous placeholder (for backrefs)
    call add(s:placeholder_texts, s:placeholder_text)

    " save length of entire placeholder for reference later
    let l:slen = len(@s)

    " remove the start and end delimiters
    let @s=substitute(@s, '\V' . g:minisnip_startdelim, '', '')
    let @s=substitute(@s, '\V' . g:minisnip_enddelim, '', '')

    " is this placeholder marked as 'evaluate'?
    if @s =~ '\V\^' . g:minisnip_evalmarker
        " remove the marker
        let @s=substitute(@s, '\V\^' . g:minisnip_evalmarker, '', '')
        " substitute in any backrefs
        let @s=substitute(@s, '\V' . g:minisnip_backrefmarker . '\(\d\)',
            \"\\=\"'\" . substitute(get(
            \    s:placeholder_texts,
            \    len(s:placeholder_texts) - str2nr(submatch(1)), ''
            \), \"'\", \"''\", 'g') . \"'\"", 'g')
        " evaluate what's left
        let @s=eval(@s)
    endif

    if empty(@s)
        " the placeholder was empty, so just enter insert mode directly
        normal! gvd
        call feedkeys(col("'>") - l:slen >= col('$') - 1 ? 'a' : 'i', 'n')
    else
        " paste the placeholder's default value in and enter select mode on it
        execute "normal! gv\"spgv\<C-g>"
    endif

    " restore old value of s register
    let @s = l:old_s
endfunction

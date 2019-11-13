" Vim syntax file
" Language:      minisnip
" Created by:    Robert Hicks <gowther@zoho.com>
" Last Change:   2017-08-20
"
" To enable syntax highlighting you just need to set the filetype
" to 'minisnip'.
"
" Adding something like the following in your vimrc will do it
" automatically for you:
"
" autocmd BufRead,BufNewFile /path/to/minisnips/* set filetype=minisnip
"
" You can add it as a grouping as well:
"
" augroup MiniSnip
"     autocmd!
"     autocmd BufRead,BufNewFile /path/to/minisnips/* set filetype=minisnip
" augroup END
"

if exists("b:current_syntax")
    finish
endif

if !exists("g:minisnip_nested_syntax")
    let g:minisnip_nested_syntax = 1
endif

if g:minisnip_nested_syntax
    let filetype = get(matchlist(expand("%:t:r"), '_\([^_]\+\)_.\+$'), 1, '')
    if !empty(filetype)
        silent! exe "runtime! syntax/" . filetype . ".vim"
        unlet! b:current_syntax
    endif
endif

" Get the minisnip defined delimiters
exe "syntax match minisnipKeyword /" . g:minisnip_startdelim . "/"
exe "syntax match minisnipKeyword /" . g:minisnip_enddelim . "/"

highlight default link minisnipKeyword Keyword

let b:current_syntax = "minisnip"

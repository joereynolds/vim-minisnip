if exists('g:loaded_minisnip')
    finish
endif

let g:loaded_minisnip = 1

" set default global variable values if unspecified by user
let g:minisnip_dir = get(g:, 'minisnip_dir', '~/.vim/minisnip')
let g:minisnip_trigger = get(g:, 'minisnip_trigger', '<Tab>')
let g:minisnip_startdelim = get(g:, 'minisnip_startdelim', '{{+')
let g:minisnip_enddelim = get(g:, 'minisnip_enddelim', '+}}')
let g:minisnip_finalstartdelim = get(g:, 'minisnip_finalstartdelim', '{{-')
let g:minisnip_finalenddelim = get(g:, 'minisnip_finalenddelim', '-}}')
let g:minisnip_evalmarker = get(g:, 'minisnip_evalmarker', '~')
let g:minisnip_donotskipmarker = get(g:, 'minisnip_donotskipmarker', '`')
let g:minisnip_backrefmarker = get(g:, 'minisnip_backrefmarker', '\\~')

" this is the pattern used to find placeholders
let g:minisnip_delimpat = '\V' . g:minisnip_startdelim . '\.\{-}' . g:minisnip_enddelim

" this is the pattern used to find placeholders
let g:minisnip_finaldelimpat = '\V' . g:minisnip_finalstartdelim .
         \ '\.\{-}' .
         \ g:minisnip_finalenddelim

" plug mappings
" the eval/escape charade is to convert ex. <Tab> into a literal tab, first
" making it \<Tab> and then eval'ing that surrounded by double quotes
inoremap <script> <expr> <Plug>(minisnip) minisnip#ShouldTrigger() ?
            \"x\<bs>\<esc>:call \minisnip#Minisnip()\<cr>" :
            \eval('"' . escape(g:minisnip_trigger, '\"<') . '"')
snoremap <script> <expr> <Plug>(minisnip) minisnip#ShouldTrigger() ?
            \"\<esc>:call \minisnip#Minisnip()\<cr>" :
            \eval('"' . escape(g:minisnip_trigger, '\"<') . '"')
inoremap <silent> <Plug>(minisnip-complete) <C-r>=minisnip#complete()<CR>

" add the default mappings if the user hasn't defined any
if !hasmapto('<Plug>(minisnip)')
    execute 'imap <unique> ' . g:minisnip_trigger . ' <Plug>(minisnip)'
    execute 'smap <unique> ' . g:minisnip_trigger . ' <Plug>(minisnip)'
endif
" Completion
if !hasmapto('<Plug>(minisnip-complete)')
    imap <C-x><C-t> <Plug>(minisnip-complete)
    inoremap <expr> <C-t> pumvisible() ?  "\<C-n>" : "\<C-t>"
    imap <expr> <CR> pumvisible() ? "\<Tab>" : "\<CR>"
endif

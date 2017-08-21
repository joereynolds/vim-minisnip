" Vim ftdetect file
" Language:      minisnip
" Created by:    Robert Hicks <gowther@zoho.com>
" Last Change:   2017-08-20
"
" This simply sets all files that are in the defined
" directory as 'minisnip'.
"

" get the snippets directory
let snippet_dir = expand(g:minisnip_dir) . "*"

execute 'autocmd BufRead,BufNewFile ' . snippet_dir . ' set filetype=minisnip'

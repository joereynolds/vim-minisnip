" install: curl https://raw.githubusercontent.com/prabirshrestha/vim-lsp/master/minimal.vimrc -o /tmp/minimal.vimrc
" uninstall: rm /tmp/plug.vim && rm -rf /tmp/plugged
" run vim/neovim with minimal.vimrc
" vim -u minimal.vimrc
" :PlugInstall

set nocompatible hidden laststatus=2

if !filereadable('/tmp/plug.vim')
  silent !curl --insecure -fLo /tmp/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

source /tmp/plug.vim
call plug#begin('/tmp/plugged')
Plug 'joereynolds/vim-minisnip'
let g:minisnip_dir='/tmp/plugged/snip'
call plug#end()

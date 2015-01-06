set nocompatible
filetype off " Disable filetype functionality to use vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Vundle plugins
Plugin 'gmarik/vundle'

" git
Plugin 'tpope/vim-fugitive'

" vim
Plugin 'tpope/vim-obsession'
Plugin 'scrooloose/nerdcommenter'
Plugin 'syngan/vim-vimlint'
Plugin 'scrooloose/nerdtree'

" syntax checking and autocomplete
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'

" syntax checking and autocomplete - Haskell
Plugin 'Shougo/neocomplete'
Plugin 'eagletmt/neco-ghc'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'lukerandall/haskellmode-vim'
Plugin 'Shougo/vimproc'
Plugin 'bitc/vim-hdevtools'

" Vundle management ends here. Turn our filetype functionality back on
call vundle#end()

" General vimrc settings
syntax on
filetype on
filetype plugin indent on
set backspace=indent,eol,start " allow backspace in insert mode.
set number
let mapleader=","
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set laststatus=2

" Plugin scrooloose/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <S-T> :NERDTreeToggle<CR>:set encoding=utf-8<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowHidden=1
let NERDTreeDirArrows=0

" Plugin 'tpope/vim-fugitive'
set statusline=%{fugitive#statusline()}\ m%F%r%h%w\ %y\ [line:%04l\ col:%04v]\ [%p%%]\ [lines:%L]

" Plugin 'Shougo/neocomplete'
let g:neocomplete#enable_at_startup=1

" Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType="context"

" Plugin 'bitc/vim-hdevtools'
let g:haddock_browser="open"
let g:haddock_browser_callformat="%s -a Firefox %s"

" Language settings
augroup HASKELL
    autocmd!
    autocmd BufEnter *.hs compiler ghc
    autocmd BufNewFile,BufRead *.hs set filetype=haskell
    autocmd BufNewFile,BufRead *.hs setlocal shiftwidth=4
    autocmd BufNewFile,BufRead *.hs setlocal tabstop=8
    autocmd BufNewFile,BufRead *.hs setlocal softtabstop=4
    autocmd BufNewFile,BufRead *.hs setlocal expandtab 
    autocmd FileType hs setlocal omnifunc=necoghc#omnifunc    
    " Plugin 'bitc/vim-hdevtools'
    autocmd FileType haskell nnoremap <buffer> <C-h> :HdevtoolsType<CR>
    autocmd FileType haskell nnoremap <buffer> <silent> <C-j> :HdevtoolsClear<CR>
    autocmd FileType haskell nnoremap <buffer> <silent> <C-k> :HdevtoolsInfo<CR>
augroup END   

augroup PYTHON
    autocmd!
    autocmd BufNewFile,BufRead *.py set filetype=python
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd BufNewFile,BufRead *.py setlocal shiftwidth=4
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4
    autocmd BufNewFile,BufRead *.py setlocal softtabstop=4
    autocmd BufNewFile,BufRead *.py setlocal expandtab
augroup END

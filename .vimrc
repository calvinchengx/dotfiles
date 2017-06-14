if has("unix")
  let s:uname = system("uname")
  let g:distro = "Linux\n"
  if s:uname == "Linux\n"
    let g:nixos = system('[[ "`cat /proc/version`" == *"NixOS"* ]] && echo NixOS')
    if g:nixos =~ "NixOS"
        let g:distro = "NixOS"
    endif
  endif
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    ":echo s:uname
  endif
endif

set nocompatible
set sessionoptions-=options
filetype off " Disable filetype functionality to use vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Vundle plugins
Plugin 'gmarik/vundle'

" git
Plugin 'tpope/vim-fugitive'
Plugin 'shumphrey/fugitive-gitlab.vim'

" vim
Plugin 'tpope/vim-obsession'
Plugin 'scrooloose/nerdcommenter'
Plugin 'syngan/vim-vimlint'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround.git'
Plugin 'Raimondi/delimitMate'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'xolox/vim-misc'      " dependency of vim-session
Plugin 'xolox/vim-session'  " vim-session is mksession on steroids

" code navigation
Plugin 'majutsushi/tagbar'

" syntax checking and autocomplete
" not loading YouCompleteMe from here if we are using NixOS
if g:distro !~ "NixOS"
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'scrooloose/syntastic'
Plugin 'maxmellon/vim-jsx-pretty'
"Plugin 'rdnetto/YCM-Generator' " generate .ycm_extra_conf.py

" syntax checking and autocomplete - Haskell
"Plugin 'Shougo/neocomplete'
Plugin 'eagletmt/neco-ghc'
" Disabled haskellmode-vim at the moment because it screws up our search
" Plugin 'lukerandall/haskellmode-vim'
if g:distro !~ "NixOS"
    " On NixOS, I have vimproc, ghcmod-vim and hdevtools installed globally via
    " /etc/nixos/configuration.nix
    Plugin 'Shougo/vimproc'
    Plugin 'eagletmt/ghcmod-vim'
    Plugin 'bitc/vim-hdevtools'
    Plugin 'Twinside/vim-syntax-haskell-cabal'
endif

Plugin 'pbrisbin/vim-syntax-shakespeare'
Plugin 'Twinside/vim-hoogle'
Plugin 'calvinchengx/lpaste'

" syntax - Dockerfile
Plugin 'ekalinin/Dockerfile.vim'

" syntax - toml
Plugin 'cespare/vim-toml'

" syntax - Jinja templates
Plugin 'lepture/vim-jinja'

" syntax - systemd service files
Plugin 'Matt-Deacalion/vim-systemd-syntax'

" syntax = yaml
Plugin 'stephpy/vim-yaml'

" syntax - vim-jade
Plugin 'digitaltoad/vim-jade'

" syntax - Elm-Lang
"Plugin 'lambdatoast/elm.vim'

" syntax checking - JavaScript
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'moll/vim-node'
Plugin 'facebook/vim-flow'

" syntax - bash
Plugin 'vim-scripts/bash-support.vim'

" syntax - Java
Plugin 'hsanson/vim-android'

" JavaScript meteor
Plugin 'Slava/tern-meteor'
Plugin 'Slava/vim-spacebars'

" syntax checking - JSON
Plugin 'elzr/vim-json'

" syntax - swift
Plugin 'keith/swift.vim'

" syntax - golang
Plugin 'fatih/vim-go'

" syntax - css
Plugin 'JulesWang/css.vim'

" syntax - haml, sass and scss
Plugin 'tpope/vim-haml'

" syntax - rainbow parentheses for lisp-y languages
Plugin 'luochen1990/rainbow'

" Solidity programming language
Plugin 'tomlion/vim-solidity'

" Hex mode editing
"Plugin 'vim-scripts/hexman.vim'

" superior lisp interaction mode for vim (slime)
Plugin 'kovisoft/slimv'

" Nix
Plugin 'MarcWeber/vim-addon-nix'
Plugin 'MarcWeber/vim-addon-manager'

" vim and tmux integration
Plugin 'jpalardy/vim-slime'
Plugin 'mhinz/vim-tmuxify'

" Running tests in vim
Plugin 'calvinchengx/vim-test'
Plugin 'tpope/vim-dispatch'

" vim-raml
Plugin 'IN3D/vim-raml'

"Plugin 'idbrii/AsyncCommand'
Plugin 'jimf/vim-red-green'
Plugin 'jimf/vim-async-make-green'

" Useful utilities
Plugin 'rafaelfranca/rtf_pygmentize'    " :RTFPygmentize
if s:uname == "Darwin\n"
Plugin 'zerowidth/vim-copy-as-rtf'      " :CopyRTF
Plugin 'airblade/vim-gitgutter'
endif

" Documentation
Plugin 'rizzatti/dash.vim'

" Just for fun
Plugin 'vim-scripts/TeTrIs.vim'  " start game with <Leader>te

" Vundle management ends here. Turn our filetype functionality back on
call vundle#end()

" General vimrc settings
syntax enable
set background=dark
colorscheme solarized
filetype on
filetype plugin indent on
set completeopt+=preview                " enable function preview with YouCompleteMe
set backspace=indent,eol,start          " allow backspace in insert mode.
set number
set incsearch
set hlsearch
let mapleader=","
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set laststatus=2
set noerrorbells visualbell t_vb=
set clipboard=unnamed
set wildmode=list:longest
map <C-s> :w<CR>
imap <C-s> <ESC> :w<CR>
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

let g:session_autosave = 'yes'

" Removes trailing spaces
 function! TrimWhiteSpace()
     %s/\s\+$//e
 endfunction

 nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
 autocmd FileWritePre    * :call TrimWhiteSpace()
 autocmd FileAppendPre   * :call TrimWhiteSpace()
 autocmd FilterWritePre  * :call TrimWhiteSpace()
 autocmd BufWritePre     * :call TrimWhiteSpace()

" fuzzy search with ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']

" Mappings to run tests
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

" Capitalization shortcuts
if (&tildeop)
  nmap gcw guw~l
  nmap gcW guW~l
  nmap gciw guiw~l
  nmap gciW guiW~l
  nmap gcis guis~l
  nmap gc$ gu$~l
  nmap gcgc guu~l
  nmap gcc guu~l
  vmap gc gu~l
else
  nmap gcw guw~h
  nmap gcW guW~h
  nmap gciw guiw~h
  nmap gciW guiW~h
  nmap gcis guis~h
  nmap gc$ gu$~h
  nmap gcgc guu~h
  nmap gcc guu~h
  vmap gc gu~h
endif

" Plugin scrooloose/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <S-T> :NERDTreeToggle<CR>:set encoding=utf-8<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowHidden=1
let NERDTreeDirArrows=0

" Plugin 'tpope/vim-fugitive'
set statusline=%{fugitive#statusline()}\ m%F%r%h%w\ %y\ [line:%04l\ col:%04v]\ [%p%%]\ [lines:%L]

" Plugin 'shumphrey/fugitive-gitlab'
let g:fugitive_gitlab_domains=["http://gitlab.calvinx.com","http://gitlab.algoaccess.com"]

" Plugin 'majutsushi/tagbar'
nmap <leader>= :TagbarToggle<CR>
let g:tagbar_autofocus=1
if executable('hasktags')
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }
endif

" Plugin 'Valloric/YouCompleteMe'
let g:ycm_server_python_interpreter = 'python'
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
" If you prefer the Omni-Completion tip window to close when a selection is
" " made, these lines close it on movement in insert mode or when leaving
" " insert mode
" This is a better approach because documentation can still be seen when
" typing
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" This method is introduced in vim 7.4 but closes the preview buffer too early
" in my opinion
" autocmd CompleteDone * pclose

" Plugin 'Shougo/neocomplete'
let g:neocomplete#enable_at_startup=1

" Plugin 'bitc/vim-hdevtools'
let g:haddock_browser="open"
let g:haddock_browser_callformat="%s -a Firefox %s"

let g:hpaste_author="calvinx"

" Plugin 'jpalardy/vim-slime'
let g:slime_target="tmux"
let g:slime_paste_file=tempname()

" Plugin 'mhinz/vim-tmuxify'
" <leader>m controls most of commands sent to tmux
let g:tmuxify_run = {
    \'sh': 'bash %',
    \'python': 'python %',
    \'haskell': 'runhaskells %',
    \}

" Applies to all filetypes
autocmd BufWritePre *.* :keepjumps :%s/\s+$//e

" Language settings
source ~/.vimrc_go
source ~/.vimrc_c
source ~/.vimrc_jade
source ~/.vimrc_yaml
source ~/.vimrc_haskell
source ~/.vimrc_python
source ~/.vimrc_jinja
source ~/.vimrc_javascript
source ~/.vimrc_json
source ~/.vimrc_ruby
source ~/.vimrc_lisp
source ~/.vimrc_markdown
source ~/.vimrc_java
source ~/.vimrc_solidity


" Using Marc Weber's VAM, in order to load his nix addon.
set nocompatible | filetype indent plugin on | syn on
set runtimepath+=~/.vim/bundle/vim-addon-manager
call vam#ActivateAddons([])
VAMActivate vim-addon-nix

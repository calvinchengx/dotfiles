set nocompatible
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

" code navigation
Plugin 'majutsushi/tagbar'

" syntax checking and autocomplete
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'mxw/vim-jsx'

" syntax checking and autocomplete - Haskell
Plugin 'Shougo/neocomplete'
Plugin 'eagletmt/neco-ghc'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'lukerandall/haskellmode-vim'
Plugin 'Shougo/vimproc'
Plugin 'bitc/vim-hdevtools'

" syntax - Jinja templates
Plugin 'lepture/vim-jinja'

" syntax - Elm-Lang
Plugin 'lambdatoast/elm.vim'

" syntax checking - JavaScript
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'moll/vim-node'

" sytnax checking - JSON
Plugin 'elzr/vim-json'

" syntax - haml, sass and scss
Plugin 'tpope/vim-haml'

" superiori lisp interaction mode for vim (slime)
Plugin 'kovisoft/slimv'

" vim and tmux integration
Plugin 'jpalardy/vim-slime'
Plugin 'mhinz/vim-tmuxify'

Plugin 'rafaelfranca/rtf_pygmentize'    " :RTFPygmentize
Plugin 'zerowidth/vim-copy-as-rtf'      " :CopyRTF

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
set backspace=indent,eol,start " allow backspace in insert mode.
set number
let mapleader=","
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set laststatus=2
set noerrorbells visualbell t_vb=
map <C-s> :w<CR>
imap <C-s> <ESC> :w<CR>

" fuzzy search with ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']

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

" Plugin 'Shougo/neocomplete'
let g:neocomplete#enable_at_startup=1

" Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType="context"

" Plugin 'bitc/vim-hdevtools'
let g:haddock_browser="open"
let g:haddock_browser_callformat="%s -a Firefox %s"

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
    " Active keys to control syntastic in haskell filetype
    autocmd FileType haskell map <silent> <Leader>e :Errors<CR>
    autocmd FileType haskell map <Leader>s :SyntasticToggleMode<CR>
    " Plugin 'bitc/vim-hdevtools'
    autocmd FileType haskell nnoremap <buffer> <C-h> :HdevtoolsType<CR>
    autocmd FileType haskell nnoremap <buffer> <silent> <C-j> :HdevtoolsClear<CR>
    autocmd FileType haskell nnoremap <buffer> <silent> <C-k> :HdevtoolsInfo<CR>
    " Plugin 'lukerandall/haskellmode-vim' and ghc-mod integration
    autocmd FileType haskell map <silent> tu :call GHC_BrowseAll()<CR> " ghc-mod reload
    autocmd FileType haskell map <silent> tw :call GHC_ShowType(1)<CR> " type lookup
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

augroup JINJA
    autocmd!
    autocmd BufNewFile,BufRead *.j2 set filetype=jinja
augroup END

augroup JAVASCRIPT
    autocmd!
    autocmd BufNewFile,BufRead *.js set filetype=javascript
    autocmd BufNewFile,BufRead *.js setlocal shiftwidth=2
    autocmd BufNewFile,BufRead *.js setlocal tabstop=4
    autocmd FileType javascript setlocal comments-=:// comments+=f://   " disable autocommenting after opening a newline
    autocmd FileType javascript let g:syntastic_javascript_checkers = ['jshint']
    autocmd FileType javascript let g:syntastic_javascript_jshint_args = '--config ' . $HOME . '/.jshintrc ' . '--exclude-path ' . $HOME . '/.jshintignore '
    autocmd FileType javascript let g:tern_map_keys=1
    autocmd FileType javascript let g:tern_show_argument_hints='on_hold'
    autocmd FileType javascript map <leader>td :TernDoc<CR>
    autocmd FileType javascript map <leader>tt :TernType<CR>
    autocmd FileType javascript map <leader>td :TernDef<CR>
    autocmd FileType javascript map <leader>tR :TernRename<CR>
augroup END

" sudo npm install syntastic-react react-tools jshint
augroup JSX
    autocmd!
    autocmd BufNewFile,BufRead *.jsx set filetype=javascript
    autocmd BufNewFile,BufRead *.jsx setlocal shiftwidth=2
    autocmd BufNewFile,BufRead *.jsx setlocal tabstop=4
    autocmd FileType jsx let g:syntastic_javascript_checkers = ['jsxhint']
    autocmd Filetype jsx let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
    autocmd FileType jsx let g:tern_map_keys=1
    autocmd FileType jsx let g:tern_show_argument_hints='on_hold'
augroup END

augroup JSON
    autocmd!
    autocmd BufNewFile,BufRead *.json set filetype=json
    autocmd FileType json let g:vim_json_syntax_conceal = 0
    autocmd FileType json let g:syntastic_json_checkers = ['jsonlint']
augroup END

augroup RUBY
    autocmd!
    autocmd BufNewFile,BufRead Gemfile set filetype=ruby
    autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
    autocmd BufNewFile,BufRead Berksfile set filetype=ruby
    autocmd BufNewFile,BufRead *.rb set filetype=ruby
    autocmd BufNewFile,BufRead *.rb setlocal shiftwidth=2
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2
    autocmd BufNewFile,BufRead *.rb setlocal softtabstop=2
augroup END

augroup LISP
    autocmd!
    autocmd BufNewFile,BufRead *.lisp set filetype=lisp
    autocmd FileType let g:slimv_swank_cmd ='! xterm -e sbcl --load ~/utils/start-swank.lisp &'
augroup END

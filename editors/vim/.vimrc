set nocompatible "turn off vi compatibility, required for vundle

filetype off

""""""""""""""""""""""""""""""""""
" Syntax and indent
""""""""""""""""""""""""""""""""""
syntax on " Turn on syntax highligthing
set showmatch  "Show matching bracets when text indicator is over them

colorscheme delek

" Mouse
if has('mouse')
  set mouse=a
endif

" Indenting
set cindent
set smartindent
set autoindent
set complete+=s

" Spell
set spell spelllang=en
set nospell
let g:tex_comment_nospell= 1

" Switch on filetype detection and loads 
" indent file (indent.vim) for specific file types
"filetype indent on
"filetype on
map Q gq
set autoindent " Copy indent from the row above
set si " Smart indent

""""""""""""""""""""""""""""""""""
" vim-plug plugin manager
""""""""""""""""""""""""""""""""""
call plug#begin()

"scripts on github
Plug 'tpope/vim-fugitive'
Plug 'Lokaltog/vim-easymotion'
"the sparkup vim script is in a subdirectory, so pass the proper one in
Plug 'rstacruz/sparkup', {'rpt': 'vim/'}

"vim-scripts repos 
Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'

Plug 'itchyny/lightline.vim'
"Plug 'bling/vim-airline'

Plug 'chrisbra/csv.vim'
Plug 'majutsushi/tagbar'
Plug 'Shougo/unite.vim'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'jmcantrell/vim-virtualenv'
Plug 'edkolev/promptline.vim'
Plug 'walm/jshint.vim'
Plug 'wlangstroth/vim-racket'

call plug#end()

"" other vim plugins
let g:ycm_key_list_previous_completion=['<Up>']

set runtimepath+=~/.vim/bundle/ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsUsePythonVersion=2


filetype plugin indent on
""""""""""""""""""""""""""""""""""
" Some other co[mn]fy settings
""""""""""""""""""""""""""""""""""
" set nu " Number lines
set hls " highlight search
set lbr " linebreak
set ruler
let g:Powerline_symbols = 'fancy' 

" Use 2 space instead of tab during format
set expandtab
set shiftwidth=2
set softtabstop=2
command R silent !runc %
vnoremap <C-c> "*y

"""""""""""""""""""""""""
" Lightline configuration
"""""""""""""""""""""""""
set laststatus=2
" set ambiwidth=double
if !has('gui_running')
    set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" Lightline functions
function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

"""""""""""""""""""""""
" Airline Configuration
"""""""""""""""""""""""
set laststatus=2
let g:airline_powerline_fonts = 1
let ttimeoutlen = 50

let g:airline#extensions#branch#enabled = 1


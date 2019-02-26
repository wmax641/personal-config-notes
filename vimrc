
filetype plugin on
" indenting and tabs are 4 spaces
set shiftwidth=4 
set tabstop=4
set expandtab

" I don't wanna follow PEP8 style
"let g:python_recommended_style = 0

:colorscheme default
   
set smartindent
set autoindent
syntax on

" completion menu
set completeopt=menuone

" use mouse
set mouse=a

" see numbered lines
set number

" make a vertical coloumn line length marker
set cc=90

"keep sceen centered around cursor (if possible)
set scrolloff=100

" vi compatibility
set nocompatible

" show current mode
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu. See :help 'wildmenu'
set wildmenu

" Automatically read a file that has changed on disk
set autoread

" normal backspace
set backspace=2

" enable status line always
set laststatus=2
set statusline=[%{&ff}]%t\ %=%2B\ col:%2c\ %l/%L\ %2P

set t_Co=256
:set cursorline
hi CursorLine ctermbg=8 ctermfg=NONE
hi StatusLine ctermbg=255 ctermfg=8
" hi Comment ctermfg=7

au InsertEnter * hi CursorLine ctermbg=52
au InsertLeave * hi CursorLine ctermbg=8
au InsertEnter * hi StatusLine ctermbg=255 ctermfg=52
au InsertLeave * hi StatusLine ctermbg=255 ctermfg=8

nnoremap  <c-n>       :tabnew<enter>
nnoremap  <a-right>   :tabn<enter>
nnoremap  <a-left>    :tabp<enter>

nnoremap  <space> za
vnoremap  <space> zf

noremap VV ^v$

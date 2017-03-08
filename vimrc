set nocompatible
" vim:set ft=vim et sw=2:

" This should come here or else it can break some mappings.
let mapleader = ","

" Pathogen is also a submodule.
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" ===========================================
" From vim-sensible.
" ===========================================
if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 1
endif

filetype plugin indent on
syntax enable

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

set incsearch

" Mapping to clear the highlighting of :set hlsearch.
if maparg('<leader><leader>', 'n') ==# ''
  nnoremap <silent> <leader><leader> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu
set lazyredraw

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=eol:$,tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Delete comment character when joining commented lines.
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Improve undo behavior a bit.
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
" ===========================================
" End vim-sensible.
" ===========================================

nnoremap ; :

nnoremap <leader>l :set list!<cr>
nnoremap <leader>d :Gvdiff<cr>
nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :CtrlPClearCache<cr>


" Enable mouse so we can actually disable it by remapping. This may sound
" fucking weird, but it is necessary since just disabling the mouse will make
" wheel events to be mapped to arrow keys.
set mouse=a
" Remap mouse events.
map <ScrollWheelUp> <Nop>
map <ScrollWheelDown> <Nop>
map <LeftMouse> <Nop>
map <MiddleMouse> <Nop>
map <RightMouse> <Nop>
map <2-LeftMouse> <Nop>
map <2-MiddleMouse> <Nop>
map <2-RightMouse> <Nop>
map <3-LeftMouse> <Nop>
map <3-MiddleMouse> <Nop>
map <3-RightMouse> <Nop>
map <4-LeftMouse> <Nop>
map <4-MiddleMouse> <Nop>
map <4-RightMouse> <Nop>

set shiftwidth=2
set tabstop=2
set expandtab

" Only use smartindent if things are not working.
" set smartindent

set number

" Use w!! to call sudo to save the file.
cmap w!! w !sudo tee > /dev/null %

set nobackup
set noswapfile

" For long lines. Goes to next line (even if it is a wrapped
" continuation of current line).
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Disable arrow keys.
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" Normal mode: x
" Insert mode: none. Use CTRL-O and a Normal mode deletion command.
inoremap <delete> <nop>
nnoremap <delete> <nop>

" Normal mode: X
" Insert mode: CTRL-H
inoremap <backspace> <nop>
nnoremap <backspace> <nop>

" No easy alternatives. But you can make it work by reading the
" help documentation.
inoremap <Pageup> <nop>
nnoremap <Pageup> <nop>
inoremap <Pagedown> <nop>
nnoremap <Pagedown> <nop>

inoremap <Home> <nop>
nnoremap <Home> <nop>
inoremap <End> <nop>
nnoremap <End> <nop>

" Set lines to the cursor - when moving vertically using j/k.
set scrolloff=2

" Ignore compiled files.
set wildignore=*.o,*~,*.pyc

" A buffer becomes hidden when it is abandoned.
set hidden

set ignorecase
set smartcase

set hlsearch

set magic

set showmatch

" No annoying sound on errors.
set noerrorbells
set novisualbell
set t_vb=
set tm=500


set encoding=utf8

" Set default tab values for non-specified extensions.
autocmd FileType python,c,cpp,rst setlocal expandtab shiftwidth=4 softtabstop=4

" Convention is 80, but we have to account for <CR>, specially when using
" :set list.
set linebreak
set textwidth=79
autocmd FileType html setlocal textwidth=120
set wrap

" Return to last edit position when opening files (You want this!).
autocmd BufReadPost *
                        \ if line("'\"") > 0 && line("'\"") <= line("$") |
                        \   exe "normal! g`\"" |
                        \ endif

" Remember info about open buffers on close.
set viminfo^=%

set statusline=%t%h%m%r%y%=%c,%l/%L\ %P

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

" Toggle spell checking.
map <F7> :setlocal spell! spelllang=en_us<CR>
map <F8> :setlocal spell! spelllang=pt_br<CR>

" Customize some colors.
hi SpellBad term=reverse cterm=reverse ctermfg=3 guifg=Black guibg=Yellow
hi SpellCap term=reverse cterm=reverse ctermfg=14 ctermbg=0 gui=bold,reverse

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

inoremap <Backspace> <C-W>
inoremap <C-h> <C-w>

if executable('ag')
  " Use ag over grep.
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Testing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup HighlightCurrentLineNumber
  " You have to call :colorscheme after this definition at least once
  " to run these at Vim startup.
  autocmd!
  set cursorline
  autocmd ColorScheme * hi clear CursorLine
  autocmd ColorScheme * hi CursorLineNR cterm=bold
augroup END
set cursorline

set t_Co=256
set background=dark
colorscheme inkpot

function! BrightHighlightOn()
  hi CursorLine ctermbg=darkred
endfunction

function! BrightHighlightOff()
  hi clear CursorLine
endfunction

let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit': 'BrightHighlightOff', }

function! EchoStrToShell(str)
  execute "!echo " . shellescape(a:str, 1)
endfunction

nnoremap <leader>e "eyy:call EchoStrToShell(@e)<CR>
vnoremap <leader>e "ey:call EchoStrToShell(@e)<CR>


set nocompatible
" vim:set ft=vim et sw=2:

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
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
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

" Pathogen is also a submodule.
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Enable filetype plugins
filetype plugin indent on
syntax enable
set autoindent
set smartindent

nmap <leader>f :CommandTFlush<CR>

set relativenumber
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

" Hotkeys for split resizing.
" TODO: probably deprecate these.
nnoremap - <c-w><
nnoremap + <c-w>>

" Split repositioning.
" TODO: use arrow for resizing instead.
nnoremap <up> <c-w>K
nnoremap <down> <c-w>J
nnoremap <left> <c-w>H
nnoremap <right> <c-w>L
nnoremap <BS> <c-w>r
nnoremap <c-BS> <c-w>R

" Disable arrow keys.
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" Disable even more keys so you can train ;).
"
" Normal mode: x
" Insert mode: none. Use CTRL-O and a Normal mode deletion
" command.
inoremap <Delete> <nop>
nnoremap <Delete> <nop>

" Normal mode: X
" Insert mode: CTRL-H
inoremap <Backspace> <nop>
nnoremap <Backspace> <nop>

" No easy alternatives. But you can make it work by reading the
" help documentation.
inoremap <Pageup> <nop>
nnoremap <Pageup> <nop>

" Same as Pageup.
inoremap <Pagedown> <nop>
nnoremap <Pagedown> <nop>

" Normal mode: 0
inoremap <Home> <nop>
nnoremap <Home> <nop>

" Normal mode: $
inoremap <End> <nop>
nnoremap <End> <nop>

" Indent full file, go back to line we were at and
" then "center window on current line".
nnoremap '= gg=G''zz

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set lines to the cursor - when moving vertically using j/k.
set scrolloff=4

" Turn on the Wild menu.
set wildmenu

" Ignore compiled files.
set wildignore=*.o,*~,*.pyc

" Always show current position.
set ruler

" Height of the command bar.
"set cmdheight=2

" A buffer becomes hidden when it is abandoned.
set hidden

" Configure backspace so it acts as it should act.
set backspace=eol,start,indent

" Ignore case when searching.
set ignorecase

" When searching try to be smart about cases .
set smartcase

" Highlight search results.
set hlsearch

" Makes search act like search in modern browsers.
set incsearch

" Don't redraw while executing macros (good performance config).
set lazyredraw

" For regular expressions turn magic on.
set magic

" Show matching brackets when text indicator is over them.
set showmatch

" No annoying sound on errors.
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256
set background=dark
colorscheme desert

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Changes CommandT color.
" For valid color schemes, use :hi in vim.
" let g:CommandTHighlightColor='Search'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs.
set expandtab

" Be smart when using tabs ;).
set smarttab

" TODO: set default tab values for non-specified extensions.
set shiftwidth=2
set tabstop=2

autocmd FileType ruby,eruby setlocal shiftwidth=2 tabstop=2
autocmd FileType python,c,cpp,rst setlocal expandtab shiftwidth=4 softtabstop=4

autocmd FileType cpp,c,ruby autocmd BufWritePre <buffer> :normal gg=G''

" TODO: fix this.
" Recommended range is 50~75. Convention is 80, but it is kinda
" ugly.
set lbr
set textwidth=65
set wrap " Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

" Visual mode pressing * or # searches for the current selection.
" Super useful! From an idea by Michael Naumann.
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Return to last edit position when opening files (You want this!).
autocmd BufReadPost *
                        \ if line("'\"") > 0 && line("'\"") <= line("$") |
                        \   exe "normal! g`\"" |
                        \ endif

" Remember info about open buffers on close.
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""

" Always show the status line.
set laststatus=2

" Format the status line.
set statusline=%t%h%m%r%y%=%c,%l/%L\ %P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
" TODO: this may be useful for everything.
func! DeleteTrailingWS()
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle spell checking.
map <F7> :setlocal spell! spelllang=en_us<CR>
map <F8> :setlocal spell! spelllang=pt_br<CR>

" Customize some colors.
hi SpellBad term=reverse cterm=reverse ctermfg=3 guifg=Black guibg=Yellow
hi SpellCap term=reverse cterm=reverse ctermfg=14 ctermbg=0 gui=bold,reverse

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Returns true if paste mode is enabled
function! HasPaste()
        if &paste
                return 'PASTE MODE  '
        en
        return ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Testing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <Backspace> <C-w>
inoremap <C-h> <C-w>


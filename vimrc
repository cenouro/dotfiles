set nocompatible
" vim:set ft=vim et sw=2:

" This should come here or else it can break some mappings.
let mapleader = ","
nnoremap ; :


" Vundle setup: clone and then run vim +PluginInstall +qall (or :PluginInstall)
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
filetype off                    " Required by Vundle.
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'   " Let Vundle manage Vundle; required.
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'morhetz/gruvbox'
call vundle#end()
filetype plugin indent on       " Also required by Vundle.


function! EchoStrToShell(str)
  execute "!echo " . shellescape(a:str, 1)
endfunction

function! EnableCursorLine()
  hi CursorLine ctermbg=darkred
endfunction

function! DisableCursorLine()
  hi clear CursorLine
endfunction

function! DeleteTrailingWS()
  exe "normal! mz"
  %s/\s\+$//ge
  exe "normal! `z"
endfunction

function! ReturnToLastEditedPosition()
  if line("'\"") > 0 && line("'\"") <= line("$")
    exe "normal! g`\""
  endif
endfunction

set number
set scrolloff=2

set nobackup noswapfile

set wildignore+=*.o,*~,*.pyc,*.gz,*.lock,*.zip,*.xlsx " Ignore useless (for Vim) files.

set hidden " A buffer becomes hidden when it is abandoned.

set ignorecase smartcase magic hlsearch
set showmatch

" No annoying sound on errors.
set noerrorbells novisualbell t_vb= tm=500

set encoding=utf8

" Convention is 80, but we have to account for <CR>, specially when using
" :set list.
set textwidth=79
set linebreak wrap

set shiftwidth=2 tabstop=2 expandtab


set viminfo^=% " Remember info about open buffers on close.

if executable('ag')
  " Use ag over grep.
  set grepprg=ag\ --nogroup\ --nocolor
endif

augroup Processors
  autocmd!
  autocmd BufWrite * :call DeleteTrailingWS()
  autocmd BufReadPost * :call ReturnToLastEditedPosition()
augroup END

augroup HighlightCurrentLineNumber
  autocmd!
  autocmd ColorScheme * :call DisableCursorLine()
  autocmd ColorScheme * hi CursorLineNR cterm=bold
augroup END

augroup LanguageSpecific
  autocmd!
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType python,c,cpp,rst setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType html setlocal textwidth=120
augroup END

" Enable mouse so we can actually disable it by remapping. Just disabling the
" mouse will make wheel events to be mapped to arrow keys.
set mouse=a
noremap <ScrollWheelUp> <Nop>
noremap <ScrollWheelDown> <Nop>
noremap <LeftMouse> <Nop>
noremap <MiddleMouse> <Nop>
noremap <RightMouse> <Nop>
noremap <2-LeftMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
noremap <2-RightMouse> <Nop>
noremap <3-LeftMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
noremap <3-RightMouse> <Nop>
noremap <4-LeftMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
noremap <4-RightMouse> <Nop>

" For long lines. Goes to next line (even if it is a wrapped continuation of
" current line.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Disable arrow keys.
inoremap <left> <Nop>
inoremap <right> <Nop>
inoremap <up> <Nop>
inoremap <down> <Nop>
nnoremap <left> <Nop>
nnoremap <right> <Nop>

" Resize split's using Up and Down.
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <C-Up> <C-w>>
nnoremap <C-Down> <C-w><

" Normal mode: x
nnoremap <delete> <nop>

" Normal mode: X
" Insert mode: <C-h>
nnoremap <backspace> <nop>
inoremap <backspace> <nop>

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

" Toggle spell checking.
noremap <F7> :setlocal spell! spelllang=en_us<CR>
noremap <F8> :setlocal spell! spelllang=pt_br<CR>

" Easier window navigation.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>e "eyy:call EchoStrToShell(@e)<CR>
vnoremap <leader>e "ey:call EchoStrToShell(@e)<CR>

nnoremap <leader>l :set list!<CR>


nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :CtrlPClearCache<cr>

set path+=**

" Parse wildignore option since ag behavior is a little different.
function WildignoreToAg()
  let res = []
  for w in split(&wildignore, ',')
    " ag's behavior for matching file extensions is different. It will match from
    " the first dot, so --ignore='*.ext' matches correctly foo.ext but not
    " foo.bar.ext. It won't match foo.ext.ext2 either.
    " Another '*' has to be added so the PATTERN works as intended (at least with
    " version 0.31.0 of ag). Also beware that ag's -g option has some weird
    " behavior as well:
    " * Without -g, --ignore seems to work as other tools, but seems ignore
    " empty files.
    " * With -g '', ag will list empty files as well, but this seems to break
    " --ignore patterns.
    if len(w) >= 3 && w[0:1] == '*.'
      let res += ["--ignore='*" . w . "'"]
    else
      let res += ["--ignore='" . w . "'"]
    endif
  endfor
  return join(res, ' ')
endfunction

" Use ag in CtrlP. Lightning fast and respects .gitignore.
if executable('ag')
  let g:ctrlp_user_command = 'ag %s ' . WildignoreToAg() . ' -l --nocolor -g ""'
endif

let g:ctrlp_buffer_func =
      \ { 'enter': 'EnableCursorLine',
      \ 'exit': 'DisableCursorLine' }


set statusline=%t%h%m%r%y%=%c,%l/%L\ %P

hi SpellBad term=reverse cterm=reverse ctermfg=3 guifg=Black guibg=Yellow
hi SpellCap term=reverse cterm=reverse ctermfg=14 ctermbg=0 gui=bold,reverse

set background=dark

" Although we aim to use millions of colors, it seems this is not cancer.
set t_Co=256

" Seems to be cancer for some colorschemes and/or terminals.
" set termguicolors

" Has to be set before applying the colorscheme.
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox


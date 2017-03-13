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

set number
set scrolloff=2

set nobackup
set noswapfile

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

" Convention is 80, but we have to account for <CR>, specially when using
" :set list.
set linebreak
set textwidth=79
set wrap
set shiftwidth=2
set tabstop=2
set expandtab

" Remember info about open buffers on close.
set viminfo^=%

if executable('ag')
  " Use ag over grep.
  set grepprg=ag\ --nogroup\ --nocolor
endif


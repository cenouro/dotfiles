nnoremap <leader>d :Gvdiff<cr>
nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :CtrlPClearCache<cr>

" Use ag in CtrlP. Lightning fast and respects .gitignore.
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_buffer_func =
      \ { 'enter': 'EnableCursorLine',
      \ 'exit': 'DisableCursorLine' }


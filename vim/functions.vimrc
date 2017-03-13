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
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunction

function! ReturnToLastEditedPosition()
  if line("'\"") > 0 && line("'\"") <= line("$") |
    exe "normal! g`\"" |
  endif
endfunction

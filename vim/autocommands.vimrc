augroup Processors
  autocmd!
  " Delete trailing white space on save.
  autocmd BufWrite * :call DeleteTrailingWS()
  " Return to last edit position when opening files.
  autocmd BufReadPost * :call ReturnToLastEditedPosition()
augroup END

augroup HighlightCurrentLineNumber
  autocmd!
  autocmd ColorScheme * :call DisableCursorLine()
  autocmd ColorScheme * hi CursorLineNR cterm=bold
augroup END

" Set default tab values for non-specified extensions.
augroup LanguageSpecific
  autocmd!
  autocmd FileType python,c,cpp,rst setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType html setlocal textwidth=120
augroup END


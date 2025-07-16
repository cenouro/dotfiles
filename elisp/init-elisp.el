;;; init-elisp.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;; The variable `byte-compile-warnings' can be tweaked in order to
;; reduce `elisp-flymake-byte-compile' "noisy" warnings.

;; Note that `byte-compile-warnings' MUST be set as a file-local
;; variable. I've tried setting it both globally and as a
;; directory-local variable, but it did not work.

;;; Code:
(with-eval-after-load 'flymake
  (add-hook 'emacs-lisp-mode-hook #'elisp/flymake-mode-without-byte-compile))

(provide 'init-elisp)
;;; init-elisp.el ends here

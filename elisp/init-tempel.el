;;; init-tempel.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'init-package)
(unless (package-installed-p 'tempel)
  (package-install 'tempel))
(require 'tempel)

(defun tempel-setup-capf ()
  "Add the Tempel Capf to `completion-at-point-functions'.

`tempel-expand' only triggers on exact matches. Alternatively use
`tempel-complete' if you want to see all matches, but then you
should also configure `tempel-trigger-prefix', such that Tempel
does not trigger too often when you don't expect it.

NOTE: We add `tempel-expand' *before* the main programming mode
Capf, such that it will be tried first."
  (setq-local completion-at-point-functions
              (cons #'tempel-complete
                    completion-at-point-functions)))

(add-hook 'conf-mode-hook #'tempel-setup-capf)
(add-hook 'prog-mode-hook #'tempel-setup-capf)
(add-hook 'text-mode-hook #'tempel-setup-capf)

(define-key tempel-map (kbd "M-n") #'tempel-next)
(define-key tempel-map (kbd "M-p") #'tempel-previous)

(provide 'init-tempel)
;;; init-tempel.el ends here

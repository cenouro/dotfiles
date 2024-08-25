;;; init-diminish.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-package)
(unless (package-installed-p 'diminish)
  (package-install 'diminish))
(require 'diminish)

(add-hook 'emacs-startup-hook
          #'(lambda ()
              (diminish 'auto-revert-mode)
              (diminish 'flyspell-mode)
              (diminish 'page-break-lines-mode)
              (diminish 'subword-mode)))

(provide 'init-diminish)
;;; init-diminish.el ends here

;;; init-helm.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-custom)
(require 'init-package)
(unless (package-installed-p 'helm)
  (package-install 'helm))
(require 'helm)

(customize-set-variable 'tab-always-indent 'complete
                        "Required for TAB completion")

(customize-set-variable 'helm-command-prefix-key nil)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(my/customize-set-variable "This disables cycling but"
                           "allows C-n/p to move through sources"
                           'helm-move-to-line-cycle-in-source nil)

(customize-set-variable 'helm-always-two-windows nil)
(customize-set-variable 'helm-default-display-buffer-functions
                        '(display-buffer-at-bottom))
(my/customize-set-variable "This is in number of lines"
                           'helm-display-buffer-default-height 13)

(helm-mode 1)
(with-eval-after-load 'diminish
  (diminish 'helm-mode))

(provide 'init-helm)
;;; init-helm.el ends here

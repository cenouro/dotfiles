;;; init.el --- My modular init.el  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
;; These must be run before everything
(add-to-list 'load-path (locate-user-emacs-file "elisp"))
(require 'init-custom)


(require 'init-package)

(require 'init-emacs)
(require 'init-imenu)
(require 'init-modus-themes)

(require 'init-diminish)
(require 'init-undo-fu)

(require 'init-ace-window)
(require 'init-all-the-icons)

(require 'init-vertico)
(require 'init-corfu)
(require 'init-orderless)
(require 'init-tempel)

(require 'init-eldoc)

(require 'init-project)
(require 'init-flymake)
(require 'init-eglot)
(require 'init-prog)
(require 'init-apache)
;; (require 'init-graphviz)
(require 'init-markdown)
(require 'init-yaml)
(require 'init-asdf)
(require 'init-ansible)
(require 'init-elisp)
(require 'init-git)
(require 'init-magit)
(require 'init-vdiff)
(require 'init-ruby)
(require 'init-python)


(unless (package-installed-p 'page-break-lines)
  (package-install 'page-break-lines))
(require 'page-break-lines)
(global-page-break-lines-mode)


(provide 'init)
;;; init.el ends here

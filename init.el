;;; init.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; After "maintaining" a highly modular init.el for more than a year,
;; I've decided to move most configuration back here. Deciding how to
;; divide things into separate files is too cumbersome, and a bunch of
;; files had very few lines.
;;
;; Modularization should be used only when it is almost unavoidable,
;; such as configurations for a programming language (e.g.
;; `init-ruby.el').

;;; Code:
;; These must be run before everything
(add-to-list 'load-path (locate-user-emacs-file "elisp"))
(require 'init-custom)


(require 'init-package)


;;;; use-package configuration
;;
(progn
  (require 'use-package)
  (my/customize-set-variable "Although use-package does not defer by"
                             "default, defer is implied by some"
                             "keywords. I prefer a more consistent"
                             "behavior of always deferring."
                             'use-package-always-defer t)

  (my/customize-set-variable "Since I intend to use builtin packages"
                             "when possible, it makes sense to only"
                             "ensure when necessary."
                             'use-package-always-ensure nil)

  (my/customize-set-variable "This use-package convenience caused me"
                             "more pain than good. Disable it."
                             'use-package-hook-name-suffix nil)

  (customize-set-variable 'use-package-use-theme nil))

(require 'init-emacs)
(require 'init-imenu)
(require 'init-modus-themes)

(require 'init-diminish)

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
(require 'init-markdown)
(require 'init-yaml)
(require 'init-asdf)
(require 'init-ansible)
(require 'init-elisp)
(require 'init-git)
(require 'init-magit)
(require 'init-vdiff)
(require 'init-ruby)


(unless (package-installed-p 'page-break-lines)
  (package-install 'page-break-lines))
(require 'page-break-lines)
(global-page-break-lines-mode)


(provide 'init)
;;; init.el ends here

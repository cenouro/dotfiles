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

  (my/customize-set-variable "Don't use a custom theme for :custom."
                             "The benefits of a custom theme are not"
                             "clear to me and it seems overkill."
                             'use-package-use-theme nil))


;;;; User Interface
;;
(use-package modus-themes
  :demand t
  :ensure t
  :custom (modus-themes-prompts '(bold))
  :config (load-theme 'modus-operandi :no-confirm))

(use-package page-break-lines
  :demand t
  :ensure t
  :config (global-page-break-lines-mode 1))


;;;; Completion
;;
(use-package vertico
  :demand t
  :ensure t
  :config (vertico-mode 1))

(use-package marginalia
  :after vertico
  :ensure t
  :config (marginalia-mode 1))

(use-package corfu
  :demand t
  :ensure t
  :custom
  ((tab-always-indent 'complete)
   (corfu-auto nil)
   (corfu-cycle t)
   (corfu-preview-current nil)
   (corfu-quit-at-boundary nil)
   (corfu-quit-no-match nil)
   (corfu-scroll-margin 3))
  :config
  (global-corfu-mode 1))

(use-package orderless
  :demand t
  :ensure t
  :custom
  ((completion-styles '(orderless basic))
   (completion-category-overrides '((file (styles basic partial-completion))
                                    (eglot (styles orderless))
                                    (eglot-capf (styles orderless))))))

(use-package tempel
  :ensure t
  :functions (tempel-next tempel-previous)
  :bind (("M-i" . #'tempel-complete)
         :map tempel-map
         ("M-n" . #'tempel-next)
         ("M-p" . #'tempel-previous)))


(require 'init-emacs)
(require 'init-imenu)

(require 'init-diminish)

(require 'init-windmove)
(require 'init-all-the-icons)

(require 'init-eldoc)

(require 'init-project)
(require 'init-flymake)
(require 'init-eglot)
(require 'init-prog)
(require 'init-apache)
(require 'init-markdown)
(require 'init-yaml)
(require 'init-asdf)
(require 'init-elisp)
(require 'init-git)
(require 'init-magit)
(require 'init-ruby)


(provide 'init)
;;; init.el ends here

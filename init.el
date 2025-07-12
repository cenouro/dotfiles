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

  (my/customize-set-variable "Never upgrade built-in packages."
                             'package-install-upgrade-built-in nil)

  (my/customize-set-variable "It's probably safe to always ensure by"
                             "default now that the option"
                             "package-install-upgrade-built-in has"
                             "been customized."
                             'use-package-always-ensure t)

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
  :custom (modus-themes-prompts '(bold))
  :config (load-theme 'modus-operandi :no-confirm))

(use-package page-break-lines
  :demand t
  :config (global-page-break-lines-mode 1))

(use-package eldoc
  :custom
  ((eldoc-echo-area-prefer-doc-buffer t)
   (eldoc-echo-area-use-multiline-p   3)))

(use-package diminish
  :init (add-hook 'emacs-startup-hook
                  #'(lambda ()
                      (diminish 'auto-revert-mode)
                      (diminish 'flyspell-mode)
                      (diminish 'page-break-lines-mode)
                      (diminish 'subword-mode))))


;;;; Completion
;;
(use-package vertico
  :demand t
  :config (vertico-mode 1))

(use-package marginalia
  :after vertico
  :config (marginalia-mode 1))

(use-package corfu
  :demand t
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
  :custom
  ((completion-styles '(orderless basic))
   (completion-category-overrides '((file (styles basic partial-completion))
                                    (eglot (styles orderless))
                                    (eglot-capf (styles orderless))))))

(use-package tempel
  :functions (tempel-next tempel-previous)
  :bind (("M-i" . #'tempel-complete)
         :map tempel-map
         ("M-n" . #'tempel-next)
         ("M-p" . #'tempel-previous)))


;;;; Version Control and Diffs
;;
(use-package vc
  :custom (vc-git-diff-switches "--patience"))

(use-package ediff
  :custom
  ((ediff-window-setup-function
    #'ediff-setup-windows-plain "Don't use a separate frame")
   (ediff-split-window-function
    #'split-window-horizontally "Diff side-by-side")))

(require 'init-magit)


;;;; Programming Languages
;;
(use-package prog-mode
  :ensure nil
  :init
  (add-hook 'prog-mode-hook #'flyspell-prog-mode)
  (add-hook 'prog-mode-hook #'(lambda () (setq truncate-lines t))))

(use-package hl-todo
  :vc "https://github.com/tarsius/hl-todo"
  :demand t
  :config (global-hl-todo-mode 1))



(require 'init-emacs)
(require 'init-imenu)

(require 'init-windmove)
(require 'init-all-the-icons)

(require 'init-project)
(require 'init-flymake)
(require 'init-eglot)
(require 'init-apache)
(require 'init-markdown)
(require 'init-yaml)
(require 'init-asdf)
(require 'init-elisp)
(require 'init-ruby)


(provide 'init)
;;; init.el ends here

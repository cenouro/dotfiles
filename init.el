;;; init.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; After experimenting for more than a year with a highly modular
;; `init.el', whose main purpose was to load a bunch of other
;; `init-*.el' files, I've decided to move most configurations back
;; here. Deciding how to divide things into separate files is too
;; cumbersome, and some files had very few lines.
;;
;; Configurations can still be grouped in dedicated `init-*.el' files
;; when doing so is self-evidently a viable option, such as when
;; setting up a programming language. Consider `init-ruby.el' as an
;; example; here is what it does (or, at least, what it was supposed
;; to do):
;;
;;   * installs an inferior shell and a package for viewing
;;     documentation;
;;   * tweaks some `compilation-mode' settings for working with Rails;
;;   * makes `eglot' work with Sorbet LSP (this also requires the
;;     ad-hoc advice `my/jsonrpc-connection-receive');
;;   * implements a skeleton for minitest
;;
;; It would be hard to argue in favor of moving all those settings to
;; `init.el'. Moreover, loading `init-ruby.el' could be deferred as a
;; whole, in a very simple way, and then loaded entirely if work is to
;; be done in a Ruby project.
;;
;; I've also decided to stop using `use-package' because it feels like
;; a glorified `progn' without the clarity and simplicity of `progn'.
;;

;;; Code:
;; These must be run before everything
(add-to-list 'load-path (locate-user-emacs-file "elisp"))
(require 'init-custom)
(require 'init-functions)


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
(prog1 :modus-themes
  (ensure-package 'modus-themes)
  (require 'modus-themes)
  (customize-set-variable 'modus-themes-prompts '(bold))
  (load-theme 'modus-operandi :no-confirm))

(use-package all-the-icons
  :if (display-graphic-p)
  :demand t
  :vc (:url "https://github.com/domtronn/all-the-icons.el"))

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

(use-package emacs
  :bind ("M-o" . #'other-window)
  :config (windmove-default-keybindings))


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
   (completion-category-overrides
    '((file (styles basic partial-completion))
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
(use-package project
  :demand t
  :custom (project-list-file "~/.local/state/emacs/projects"))

(use-package prog-mode
  :ensure nil
  :init
  (add-hook 'prog-mode-hook #'flyspell-prog-mode)
  (add-hook 'prog-mode-hook #'(lambda () (setq truncate-lines t))))

(use-package hl-todo
  :vc (:url "https://github.com/tarsius/hl-todo")
  :demand t
  :config (global-hl-todo-mode 1))

(use-package apache-mode)

(use-package markdown-mode)

(use-package yaml-mode
  :config
  (add-hook 'yaml-mode-hook #'(lambda () (setq truncate-lines t))))

(use-package asdf
  :demand t
  :vc (:url "https://github.com/cenouro/asdf.el")
  :functions (asdf-enable)
  :config (asdf-enable))



(require 'init-emacs)
(require 'init-imenu)

(require 'init-flymake)
(require 'init-eglot)
(require 'init-elisp)
(require 'init-ruby)


(provide 'init)
;;; init.el ends here

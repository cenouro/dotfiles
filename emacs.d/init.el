;;; -*- lexical-binding: t -*-

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(column-number-mode)
(setq show-paren-delay 0)
(show-paren-mode)

(prefer-coding-system 'utf-8)

;; TODO: Test function/mode existance instead of relying on version number.
(if (version<= "26.0.50" emacs-version)
    (global-display-line-numbers-mode)
  (global-linum-mode)
  (setq linum-format "%3d"))

(setq inhibit-startup-message t)
(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default indent-tabs-mode nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(defvar my-term-shell "/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "<C-return>") 'ansi-term)

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(eval-when-compile
  (require 'use-package))

;; Attempt to improve ESC-ESC-ESC (keyboard-escape-quit closes splits).
(global-set-key [escape] 'keyboard-quit)
(global-set-key (kbd "<C-escape>") 'keyboard-escape-quit)

(use-package magit
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package evil
  :ensure t
  :init
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ",")
    (evil-leader/set-key
      "e" 'eval-defun
      "l" 'whitespace-mode
      "s" 'delete-trailing-whitespace
      "," 'other-window
      "o" 'delete-other-windows))
  :config
  (evil-mode))

(use-package evil-vimish-fold
  :ensure t
  :init
  (use-package vimish-fold
    :ensure t
    :config
    (vimish-fold-global-mode 1))
  :config
  (evil-vimish-fold-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-allow-evil-operators nil))

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (yaml-mode evil-leader origami evil-vimish-fold magit helm beacon use-package which-key spacemacs-theme evil evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 125 :width normal :foundry "Bits" :family "Ubuntu Mono")))))

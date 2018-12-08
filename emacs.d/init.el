;;; -*- lexical-binding: t -*-

;; Package 'infra' stuff.
;{{{
(package-initialize)
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(eval-when-compile
  (require 'use-package))
;}}}

;; Sane configs.
;{{{
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(toggle-frame-maximized)

(column-number-mode)
(show-paren-mode)

(prefer-coding-system 'utf-8)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq inhibit-startup-message t
      scroll-conservatively 100
      show-paren-delay 0
      ring-bell-function 'ignore)

(setq-default indent-tabs-mode nil)

(setq make-backup-files nil
      auto-save-default nil)

(defalias 'yes-or-no-p 'y-or-n-p)
;}}}

;; Line numbers config.
;{{{
(setq-default display-line-numbers-type 'relative
              display-line-numbers-width 3
              linum-format "%3d")
(if (fboundp 'global-display-line-numbers-mode)
    (global-display-line-numbers-mode)
  (global-linum-mode))
;}}}

;; Mappings.
;{{{
(global-set-key (kbd "<C-return>") (lambda ()
                                     (interactive)
                                     (ansi-term "/bin/zsh")))

;; Attempt to improve ESC-ESC-ESC (keyboard-escape-quit closes splits).
(global-set-key [escape] 'keyboard-quit)
(global-set-key (kbd "<C-escape>") 'keyboard-escape-quit)
;}}}

;; Packages.
;{{{
(setq use-package-always-ensure t)

(use-package yaml-mode :defer t)
(use-package beacon :init (beacon-mode 1))

(use-package origami
  :config
  (add-hook 'prog-mode-hook (lambda ()
                              (setq-local origami-fold-style 'triple-braces)
                              (origami-mode)
                              (origami-close-all-nodes (current-buffer)))))

(use-package magit :defer t)
(add-hook 'magit-mode-hook (lambda ()
                             (local-unset-key "j")
                             (local-set-key "k" 'magit-section-backward)
                             (local-set-key "j" 'magit-section-forward)))

(use-package evil
  :init
  (use-package evil-leader
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
  (evil-mode)
  (evil-set-initial-state 'dired-mode 'emacs)
  (define-key evil-insert-state-map (kbd "C-h") 'backward-delete-char-untabify))

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-allow-evil-operators nil))
;}}}


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
    (origami yaml-mode evil-leader evil-vimish-fold magit beacon use-package which-key spacemacs-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 125 :width normal :foundry "Bits" :family "Ubuntu Mono")))))

;;; init-emacs.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:

;;; Bindings and QoL
;;
(global-set-key (kbd "C-x k")   #'kill-this-buffer)
(global-set-key (kbd "C-x C-b") #'ibuffer)

(global-set-key (kbd "C-c v g f") #'find-file-at-point)

(electric-pair-mode 1)
(global-subword-mode 1)

(require 'savehist)
(savehist-mode)


;;; Encoding, whitespace and tabs
;;
(prefer-coding-system		'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment   "UTF-8")

(add-hook 'before-save-hook
          #'delete-trailing-whitespace)

(customize-set-variable 'indent-tabs-mode nil)
(customize-set-variable 'tab-stop-list nil)
(customize-set-variable 'tab-width 4)
(customize-set-variable 'backward-delete-char-untabify-method nil)


;;; Security
;;
(defun cnr/clear-view-lossage ()
  "Prevent `view-lossage' from leaking passwords.
See `comint-send-invisible' for security note."
  (clear-this-command-keys))

(advice-add 'view-lossage :before #'cnr/clear-view-lossage)


;;; Sane defaults
;;
(customize-set-variable 'history-delete-duplicates t)
(customize-set-variable 'require-final-newline     t)
(customize-set-variable 'scroll-conservatively     most-positive-fixnum)
(customize-set-variable 'sentence-end-double-space nil)


;;; Relevant UI configurations
;;
(customize-set-variable 'ansi-color-for-compilation-mode t)
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)

(set-fringe-mode 12)
(customize-set-variable 'ring-bell-function #'ignore)

;; Don't show line numbers, but configure them just in case
(customize-set-variable 'display-line-numbers-type 'visual)
(customize-set-variable 'display-line-numbers-width 3)

;; Cursor
(blink-cursor-mode -1)
(global-hl-line-mode 1)

(add-hook 'activate-mark-hook   #'(lambda () (setq cursor-type 'bar)))
(add-hook 'deactivate-mark-hook #'(lambda () (setq cursor-type 'box)))

;; Modeline tweaks
(column-number-mode 1)

;; Typeface
(defun cnr/scale-font-height (height)
  "Scale HEIGHT when Gnome's Large Text is enabled."
  (let* ((gsettings-cmd "gsettings get org.gnome.desktop.interface text-scaling-factor")
         (text-scaling-factor (string-to-number (shell-command-to-string gsettings-cmd))))
    ;; x * text-scaling-factor = HEIGHT
    ;; x = HEIGHT / text-scaling-factor
    (/ height text-scaling-factor)))

(set-face-attribute 'default nil
                    :family "JetBrains Mono"
                    :height (round (cnr/scale-font-height 140))
                    :slant  'normal
                    :weight 'normal
                    :width  'normal)


;;; Show Matching Parenthesis
;;
(show-paren-mode 1)
(customize-set-variable 'show-paren-delay 0)


;;; Auto-save and backups
;;
(customize-set-variable 'auto-save-default nil)
(customize-set-variable 'auto-save-list-file-prefix
                        "~/.local/state/emacs/auto-saves/.saves-")
(customize-set-variable 'auto-save-file-name-transforms
                        '((".*" "~/.local/state/emacs/auto-saves/" t)))
(customize-set-variable 'auto-save-interval 256)
(customize-set-variable 'auto-save-timeout  120)

(customize-set-variable 'make-backup-files nil)
(customize-set-variable 'backup-directory-alist
                        '((".*" . "~/.local/state/emacs/backups")))
(customize-set-variable 'backup-by-copying t "Don't clobber symbolic links")
(customize-set-variable 'delete-old-versions t)
(customize-set-variable 'kept-new-versions 6)
(customize-set-variable 'kept-old-versions 2)
(customize-set-variable 'vc-make-backup-files nil)
(customize-set-variable 'version-control t "Use versioned backups")


;;; The usual suspects
;;
(customize-set-variable 'inhibit-startup-screen t)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)


(provide 'init-emacs)
;;; init-emacs.el ends here

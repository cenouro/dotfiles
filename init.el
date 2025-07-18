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
;; Regarding use-package:
;;
;; I've also decided to stop using `use-package'. Since it tries its
;; best to do the right thing, it's a very good package for those new
;; to Emacs and a lot can be learned from it's macro expansions.
;;
;; However, I've come to realize that use-package's keywords are no
;; better than simply using functions that do the same thing. The most
;; obvious example would be the `:custom' keyword vs `setopt'; even
;; before `setopt' was part of Emacs, I had implemented an ad-hoc
;; function that had the same behavior and signature.
;;
;; The point here is that I'd rather use `progn' and functions instead
;; of `use-package' keywords. And I also had this idea of using
;; keywords in `progn' for organization and labeling purposes.
;; Keywords are symbols that self-evaluate in Elisp, so they are
;; pretty much a no-op in `progn'.
;;

;;; Code:
;; These must be run before everything
(add-to-list 'load-path (locate-user-emacs-file "elisp"))
(require 'init-custom)
(require 'init-functions)


(require 'init-package)


;;;; User Interface
;;
(prog1 :modus-themes
  (ensure-package 'modus-themes)
  (require 'modus-themes)
  (customize-set-variable 'modus-themes-prompts '(bold))
  (load-theme 'modus-operandi :no-confirm))

(prog1 :all-the-icons
  (ensure-vc-package
   'all-the-icons
   (github "domtronn/all-the-icons.el"))
  (when (display-graphic-p)
    (require 'all-the-icons)))

(prog1 :page-break-lines
  (ensure-package 'page-break-lines 'nongnu)
  (global-page-break-lines-mode 1))

(prog1 :eldoc
  (setopt eldoc-echo-area-prefer-doc-buffer t
          eldoc-echo-area-use-multiline-p   3))

(prog1 :diminish
  (ensure-package 'diminish)
  (add-hook 'emacs-startup-hook
            #'(lambda ()
                (diminish 'auto-revert-mode)
                (diminish 'flyspell-mode)
                (diminish 'page-break-lines-mode)
                (diminish 'subword-mode))))

(prog1 :emacs
  (windmove-default-keybindings)
  (keymap-global-set "M-o" #'other-window))


;;;; Completion
;;
(prog1 :vertico
  (ensure-package 'vertico)
  (vertico-mode 1))

(prog1 :marginalia
  (ensure-package 'marginalia)
  (marginalia-mode 1))

(prog1 :corfu
  (ensure-package 'corfu)
  (setopt tab-always-indent 'complete
          corfu-auto nil
          corfu-cycle t
          corfu-preview-current nil
          corfu-quit-at-boundary nil
          corfu-quit-no-match nil
          corfu-scroll-margin 3)
  (global-corfu-mode 1))

(prog1 :orderless
  (ensure-package 'orderless)
  (require 'orderless)
  (setopt completion-styles '(orderless basic)
          completion-category-overrides
          '((file (styles basic partial-completion))
            (eglot (styles orderless))
            (eglot-capf (styles orderless)))))

(prog1 :tempel
  (ensure-package 'tempel)
  (keymap-global-set "M-i" #'tempel-complete)
  (with-eval-after-load 'tempel
    (keymap-set tempel-map "M-n" #'tempel-next)
    (keymap-set tempel-map "M-p" #'tempel-previous)))


;;;; Version Control and Diffs
;;
(prog1 :vc-git
  (customize-set-variable 'vc-git-diff-switches "--patience"))

(prog1 :ediff
  (customize-set-variable
   'ediff-window-setup-function
   #'ediff-setup-windows-plain "Don't use a separate frame")
  (customize-set-variable
   'ediff-split-window-function
   #'split-window-horizontally "Diff side-by-side"))

(prog1 :magit
  (ensure-package 'magit 'nongnu)
  (require 'magit)
  (setopt    git-commit-major-mode #'my/git-commit-mode)
  (add-hook 'git-commit-setup-hook #'git-commit-turn-on-auto-fill)
  (add-hook 'git-commit-setup-hook #'git-commit-turn-on-flyspell))


;;;; Programming Languages
;;
(prog1 :project
  (require 'project)
  (setopt project-list-file "~/.local/state/emacs/projects"))

(prog1 :eglot
  (require 'eglot)
  (my/customize-set-variable
   "I've tested Eglot+Imenu a bit in a Ruby+Sorbet project and it"
   "bugs when *Rescan* is used, whereas Imenu works fine by itself."
   'eglot-stay-out-of '(imenu))
  (when (version<= emacs-version "30")
    (advice-add #'jsonrpc-connection-receive :before
                #'my/jsonrpc-connection-receive)))

(prog1 :prog-mode
  (add-hook 'prog-mode-hook #'flyspell-prog-mode)
  (add-hook 'prog-mode-hook #'(lambda () (setq truncate-lines t))))

(prog1 :hl-todo
  (ensure-vc-package 'hl-todo (github "tarsius/hl-todo"))
  (global-hl-todo-mode 1))

(prog1 :apache-mode
  (ensure-package 'apache-mode 'nongnu))

(prog1 :markdown-mode
  (ensure-package 'markdown-mode 'nongnu))

(prog1 :yaml-mode
  (ensure-package 'yaml-mode 'nongnu)
  (with-eval-after-load 'yaml-mode
    (add-hook 'yaml-mode-hook
              #'(lambda () (setq truncate-lines t)))))

(prog1 :asdf
  (ensure-vc-package 'asdf (github "cenouro/asdf.el"))
  (require 'asdf)
  (asdf-enable))

(prog1 :elisp
  (with-eval-after-load 'flymake
    (add-hook 'emacs-lisp-mode-hook
              #'elisp/flymake-mode-without-byte-compile)))

(prog1 :ruby-mode
  (ensure-package 'inf-ruby 'nongnu)
  (ensure-vc-package 'yari (github "hron/yari.el"))
  (with-eval-after-load 'ruby-mode
    (require 'init-ruby)))



(require 'init-emacs)
(require 'init-flymake)


(provide 'init)
;;; init.el ends here

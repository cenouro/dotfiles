;;; init-magit.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-package)

(unless (package-installed-p 'magit)
  (package-install 'magit))
(require 'magit)

(define-derived-mode cnr/git-commit-mode text-mode "Commit"
  "Major mode for editing Git commit messages.

Intended to be used as `git-commit-major-mode'. A lot of modes
derive from `text-mode' (e.g. `nxml-mode'); using a dedicated
major mode for commit messages allows for simpler customization."
  (setq fill-column 72))

(customize-set-variable 'git-commit-major-mode #'cnr/git-commit-mode)

(add-hook 'git-commit-setup-hook #'git-commit-turn-on-auto-fill)
(add-hook 'git-commit-setup-hook #'git-commit-turn-on-flyspell)


(unless (package-installed-p 'magit-todos)
  (package-vc-install (github "alphapapa/magit-todos")))
(require 'magit-todos)
(magit-todos-mode 1)

(provide 'init-magit)
;;; init-magit.el ends here

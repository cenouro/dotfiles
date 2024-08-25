;;; init-undo-tree.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-package)
(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))
(require 'undo-tree)

(customize-set-variable 'undo-tree-history-directory-alist
                        '(("." . "~/.local/state/emacs/undo-tree")))
(customize-set-variable 'undo-tree-incompatible-major-modes
                        '(cnr/git-commit-mode term-mode))

(global-undo-tree-mode)

(provide 'init-undo-tree)
;;; init-undo-tree.el ends here

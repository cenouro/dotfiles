;;; init-git.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;


;;; Code:
(with-eval-after-load 'vc-git
  (customize-set-variable 'vc-git-diff-switches "--patience"))


(with-eval-after-load 'ediff
  (customize-set-variable 'ediff-window-setup-function
                          'ediff-setup-windows-plain
                          "Don't use a separate frame")
  (customize-set-variable 'ediff-split-window-function
                          'split-window-horizontally
                          "Diff side-by-side"))


(provide 'init-git)

;;; init-git.el ends here

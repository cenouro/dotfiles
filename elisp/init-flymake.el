;;; init-flymake.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'flymake)
(define-key flymake-mode-map (kbd "C-c f p") #'flymake-goto-prev-error)
(define-key flymake-mode-map (kbd "C-c f n") #'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "C-c f f") #'flymake-show-buffer-diagnostics)

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flymake diagnostics for ")
               (display-buffer-reuse-window
                display-buffer-in-side-window)
               (side            . bottom)
               (reusable-frames . visible)
               (window-height   . 0.2)))


(ensure-vc-package 'flymake-languagetool
                   (github "emacs-languagetool/flymake-languagetool"))

(require 'flymake-languagetool)
(customize-set-variable 'flymake-languagetool-server-jar
                        (concat "/opt/" (user-login-name)
                                "/LanguageTool/languagetool-server.jar"))

(defun my/flymake-languagetool-load ()
  "Load languagetool and then enable flymake."
  (progn
    (flymake-languagetool-load)
    (flymake-mode 1)))

(with-eval-after-load 'init-magit
  (my/add-to-list "Disable LanguageTool in Git commit comments."
                  'flymake-languagetool-ignore-faces-alist
                  '(cnr/git-commit-mode font-lock-comment-face
                                        git-commit-comment-action
                                        git-commit-comment-branch-local
                                        git-commit-comment-branch-remote
                                        git-commit-comment-detached
                                        git-commit-comment-file
                                        git-commit-comment-heading))

  (add-hook 'cnr/git-commit-mode-hook #'my/flymake-languagetool-load))

(provide 'init-flymake)
;;; init-flymake.el ends here

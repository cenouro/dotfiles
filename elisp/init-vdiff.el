;;; init-vdiff.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'package)

(unless (package-installed-p 'vdiff)
  (package-install 'vdiff))
(unless (package-installed-p 'vdiff-magit)
  (package-vc-install `(vdiff-magit
                        :url ,(github "justbur/emacs-vdiff-magit")
                        :main-file "vdiff-magit.el")))


(require 'vdiff)

(define-key vdiff-mode-map      (kbd "C-c") vdiff-mode-prefix-map)
(define-key vdiff-3way-mode-map (kbd "C-c") vdiff-mode-prefix-map)

(customize-set-variable 'vdiff-diff-algorithm 'git-diff-patience)


(with-eval-after-load 'magit
  (require 'vdiff-magit)
  (customize-set-variable 'vdiff-magit-stage-is-2way t)

  (define-key magit-mode-map "e" #'vdiff-magit-dwim)
  (define-key magit-mode-map "E" #'vdiff-magit)

  (transient-suffix-put #'magit-dispatch "e" :description "Vdiff (dwim)")
  (transient-suffix-put #'magit-dispatch "e" :command    #'vdiff-magit-dwim)
  (transient-suffix-put #'magit-dispatch "E" :description "Vdiff")
  (transient-suffix-put #'magit-dispatch "E" :command    #'vdiff-magit))


(provide 'init-vdiff)
;;; init-vdiff.el ends here

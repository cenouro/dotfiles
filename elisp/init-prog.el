;;; init-prog.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Configurations, packages and settings that are useful for more than
;; a single programming language.

;;; Code:
(require 'package)
(unless (package-installed-p 'hl-todo)
  (package-vc-install (github "tarsius/hl-todo")))


(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'prog-mode-hook #'(lambda () (setq truncate-lines t)))


(require 'hl-todo)
(global-hl-todo-mode)

(provide 'init-prog)
;;; init-prog.el ends here

;;; init-yaml.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-package)

(unless (package-installed-p 'yaml-mode)
  (package-install 'yaml-mode))
(require 'yaml-mode)

(add-hook 'yaml-mode-hook #'(lambda () (setq truncate-lines t)))


(require 'autoinsert)
(add-hook 'yaml-mode-hook #'(lambda ()
                              (setq-local auto-insert-query nil)
                              (auto-insert)))
(add-to-list 'auto-insert-alist '(yaml-mode . (nil "---\n" _  "\n...\n")))

(provide 'init-yaml)
;;; init-yaml.el ends here

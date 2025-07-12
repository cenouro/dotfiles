;;; init-apache.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-package)

(unless (package-installed-p 'apache-mode)
  (package-install 'apache-mode))
(require 'apache-mode)

(provide 'init-apache)
;;; init-apache.el ends here

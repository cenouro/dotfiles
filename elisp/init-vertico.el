;;; init-vertico.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-custom)
(require 'init-package)

(unless (package-installed-p 'vertico)
  (package-install 'vertico))
(require 'vertico)
(vertico-mode 1)

(unless (package-installed-p 'marginalia)
  (package-install 'marginalia))
(require 'marginalia)
(marginalia-mode 1)

(provide 'init-vertico)
;;; init-vertico.el ends here

;;; init-orderless.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-custom)
(require 'init-package)

(unless (package-installed-p 'orderless)
  (package-install 'orderless))
(require 'orderless)

(customize-set-variable 'completion-styles '(orderless basic))
(customize-set-variable 'completion-category-overrides
                        '((file (styles basic partial-completion))
                          (eglot (styles orderless))
                          (eglot-capf (styles orderless))))

(provide 'init-orderless)
;;; init-orderless.el ends here

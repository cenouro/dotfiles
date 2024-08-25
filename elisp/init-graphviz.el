;;; init-graphviz.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-custom)
(require 'init-package)
(require 'init-prog)

(unless (package-installed-p 'graphviz-dot-mode)
  (package-vc-install "https://github.com/ppareit/graphviz-dot-mode"))
(require 'graphviz-dot-mode)

(my/customize-set-variable "Ad hoc fix for preview glitch."
                           "See ppareit/graphviz-dot-mode/issues/75"
                           "for details."
                           'graphviz-dot-preview-extension "svg")

(provide 'init-graphviz)
;;; init-graphviz.el ends here

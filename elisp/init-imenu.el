;;; init-imenu.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'init-custom)

(with-eval-after-load 'eglot
  (my/customize-set-variable "I've tested Eglot+Imenu a bit in a Ruby+Sorbet"
                             "project and it bugs when *Rescan* is used,"
                             "whereas Imenu works fine by itself."
                             'eglot-stay-out-of '(imenu)))

(provide 'init-imenu)
;;; init-imenu.el ends here

;;; init-asdf.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(with-eval-after-load 'init-package
  (unless (package-installed-p 'asdf)
    (package-vc-install (github "cenouro/asdf.el")))

  (require 'asdf)
  (asdf-enable))


(provide 'init-asdf)
;;; init-asdf.el ends here

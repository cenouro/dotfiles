;;; init-all-the-icons.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'package)
(unless (package-installed-p 'all-the-icons)
  (progn
    (package-vc-install (github "domtronn/all-the-icons.el"))
    (require 'all-the-icons)
    (all-the-icons-install-fonts t)))


(when (display-graphic-p)
  (require 'all-the-icons))

(provide 'init-all-the-icons)
;;; init-all-the-icons.el ends here

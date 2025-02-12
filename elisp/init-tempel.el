;;; init-tempel.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'init-package)
(unless (package-installed-p 'tempel)
  (package-install 'tempel))
(require 'tempel)

(define-key global-map (kbd "M-i") #'tempel-complete)
(define-key tempel-map (kbd "M-n") #'tempel-next)
(define-key tempel-map (kbd "M-p") #'tempel-previous)

(provide 'init-tempel)
;;; init-tempel.el ends here

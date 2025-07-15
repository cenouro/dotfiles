;;; init-eglot.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'init-package)
(unless (package-installed-p 'eglot)
  (package-install 'eglot))
(require 'eglot)


(when (version<= emacs-version "30")
  (advice-add #'jsonrpc-connection-receive :before
              #'my/jsonrpc-connection-receive))

(provide 'init-eglot)
;;; init-eglot.el ends here

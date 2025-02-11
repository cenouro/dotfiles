;;; init-eglot.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'init-package)
(unless (package-installed-p 'eglot)
  (package-install 'eglot))
(require 'eglot)

(defun my/jsonrpc-connection-receive (connection message)
  "Remove \"bad\" keys from LSP requests.

Emacs' JSON-RPC library is very strict when parsing LSP
responses. For example, Ruby's Sorbet sends a \"requestMethod\"
property in its responses, which is not part of the official LSP
spec.

This function is meant to be used as an advice that removes
\"bad\" properties from responses before Emacs parses them."
  (cl--do-remf message :requestMethod))

(when (version<= emacs-version "30")
  (advice-add #'jsonrpc-connection-receive :before
              #'my/jsonrpc-connection-receive))


(defun my/capf-tempel-before-eglot ()
  "Make tempel have higher precedence than eglot.

The `tags-completion-at-point-function' was already there and
thus is preserved.

NOTE for myself: don't try to install and use cape because it
does not work as intended."
  (setq-local completion-at-point-functions
              '(tempel-complete
                eglot-completion-at-point
                tags-completion-at-point-function)))

(with-eval-after-load 'tempel
  (add-hook 'eglot-managed-mode-hook #'my/capf-tempel-before-eglot))

(provide 'init-eglot)
;;; init-eglot.el ends here

;;; init-functions.el --- my ad-hoc defuns  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; The purpose of this files is to hold ALL my custom functions.
;;
;; Why put every function here? Because deciding how to divide
;; functions into separate files is too cumbersome. Think of this file
;; as being analogous to `init.el', the difference being that
;; `init.el' contains configurations, whereas this file contains only
;; functions.
;;
;; Now, here are the rules regarding the organization and quality of
;; this file:
;;
;;   * this file requires no organization whatsoever because
;;     navigation can easily be done through `imenu';
;;   * in fact, `imenu' can even handle functions that have been
;;     implemented inside `with-eval-after-load', so don't hesitate
;;     and use put code inside `with-eval-after-load' when necessary;
;;   * strive for perfection in docstrings
;;

;;; Code:
;;
(defun my/customize-set-variable (&rest comment)
  "My decorated `customize-set-variable'.

The standard `customize-set-variable' has COMMENT as it's last
argument, which can lead to weird indentation and ugly code. This
function has COMMENT at the beginning, which should provide
better legibility.

More than one COMMENT string can be used, in which case the
strings will be properly joined using a space as separator.

VARIABLE and VALUE are both required and will be passed directly
to `customize-set-variable'.

\(fn [COMMENT...] VARIABLE VALUE\)"
  (let* ((args comment)
         (variable-and-value (last args 2))
         (comments (butlast args 2)))
    (when (length< args 2)
      (signal 'wrong-number-of-arguments
              "at least 2 arguments are required"))
    (customize-set-variable (nth 0 variable-and-value)
                            (nth 1 variable-and-value)
                            (string-trim (string-join comments " ")))))


(defun my/add-to-list (comment list-var element &optional append compare-fn)
  "My decorated `add-to-list'.
Like `add-to-list', but actually uses `customize-set-variable'.

COMMENT is passed to `customize-set-variable'.
LIST-VAR, ELEMENT, APPEND and COMPARE-FN are passed to `add-to-list'."
  (customize-set-variable list-var
                          (add-to-list list-var element append compare-fn)
                          comment))


(defun my/jsonrpc-connection-receive (connection message)
  "Remove \"bad\" keys from LSP requests.

Emacs' JSON-RPC library is very strict when parsing LSP
responses. For example, Ruby's Sorbet sends a \"requestMethod\"
property in its responses, which is not part of the official LSP
spec.

This function is meant to be used as an advice that removes
\"bad\" properties from responses before Emacs parses them."
  (cl--do-remf message :requestMethod))


(defun ensure-package (package-name &optional archive)
  "Install PACKAGE-NAME if it's not already installed.

ARCHIVE, a symbol or string, is used to pin the package to that specific
archive. It's default value is \"gnu\"."
  (let* ((archive (cond ((null archive)    "gnu")
                        ((symbolp archive) (symbol-name archive))
                        ((stringp archive) archive)))
         (pack-arch (cons package-name archive)))
    (if package-pinned-packages
        (setopt package-pinned-packages
                (add-to-list 'package-pinned-packages pack-arch))
      (setopt package-pinned-packages (list pack-arch)))

    (unless (package-installed-p package-name)
      ;; I've done some testing and looked at how use-package does its
      ;; pinning; my conclusion is that, in order for pinning to
      ;; actually work, `package-read-all-archive-contents' must be
      ;; called every time after `package-pinned-packages' is updated.
      ;; Logically, this would be done above, after the calls to
      ;; `setopt'; but, as a "performance hack", it's done here, only
      ;; if the package must be installed.
      (package-read-all-archive-contents)
      (package-install package-name))))


(defun ensure-vc-package (package-name url)
  "Use `package-vc-install' to ensure PACKAGE-NAME is installed."
  (unless (package-installed-p package-name)
    (package-vc-install url)))


(with-eval-after-load 'flymake
  (defun elisp/flymake-mode-without-byte-compile ()
    "Disable `elisp-flymake-byte-compile' and start `flymake-mode'.

`elisp-flymake-byte-compile' was not really designed for configuration
files such as `init.el'; it complains (incorrectly) too much
about undefined variables and functions."
    (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-byte-compile t)
    (flymake-mode 1)))


(provide 'init-functions)
;;; init-functions.el ends here

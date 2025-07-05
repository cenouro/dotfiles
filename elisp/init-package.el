;;; init-package.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;; Initializes and configures package.el. This file also installs
;; dash.el, s.el and f.el, which are common dependencies for some
;; other packages.

;; Note that neither MELPA nor MELPA Stable are used. These archives
;; can become unavailable for some hours (probably because all
;; packages are being rebuilt), making Emacs unresponsive if
;; package-refresh-contents is used.

;;; Code:

(defun github (repo)
  (concat "https://github.com/" repo))

(defun github-file (repo file)
  (concat (github repo) "/raw/master/" file))

(require 'package)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(customize-set-variable 'package-vc-register-as-project nil)


;;; Common dependencies for other packages:

(unless (package-installed-p 'dash)
  (package-install 'dash))

;; s.el and f.el are installed by dumping the relevant files somewhere
;; in the load path. This is done to avoid byte-compiler errors from
;; irrelevant files (such as test files).
(let ((dumpster (expand-file-name "github" package-user-dir)))
  (make-directory dumpster 'noerror)
  (add-to-list 'load-path dumpster)

  (unless (require 's nil 'noerror)
    (url-copy-file (github-file "magnars/s.el" "s.el")
                   (expand-file-name "s.el" dumpster)
                   'noclobber))
  (unless (require 'f nil 'noerror)
    (url-copy-file (github-file "rejeep/f.el" "f.el")
                   (expand-file-name "f.el" dumpster)
                   'noclobber))
  (unless (require 'f-shortdoc nil 'noerror)
    (url-copy-file (github-file "rejeep/f.el" "f-shortdoc.el")
                   (expand-file-name "f-shortdoc.el" dumpster)
                   'noclobber)))

(provide 'init-package)
;;; init-package.el ends here

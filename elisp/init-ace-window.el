;;; init-ace-window.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'package)
(unless (package-installed-p 'ace-window)
  (package-install 'ace-window))


(customize-set-variable 'aw-keys '(?f ?d ?j ?k ?s ?l))


(require 'ace-window)
(global-set-key (kbd "M-o") #'ace-window)

(provide 'init-ace-window)
;;; init-ace-window.el ends here

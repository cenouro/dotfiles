;;; init-undo-fu.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(require 'init-package)
(unless (package-installed-p 'undo-fu)
  (package-install 'undo-fu))
(require 'undo-fu)

;; keys inspired by vim
(global-set-key (kbd "C-c C-r") #'undo-fu-only-redo)
(global-set-key (kbd "C-c u") #'undo-fu-only-undo)
(global-set-key [remap undo] #'undo-fu-only-undo)

(provide 'init-undo-fu)
;;; init-undo-fu.el ends here

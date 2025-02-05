;;; init-python.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(if (executable-find "pyflakes")
    (add-hook 'python-mode-hook #'flymake-mode))

(provide 'init-python)
;;; init-python.el ends here

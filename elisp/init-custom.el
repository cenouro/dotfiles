;;; init-custom.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(customize-set-variable 'custom-file "~/.emacs.d/custom.el"
                        (concat "must be set and loaded as early as "
                                "possible to avoid problems"))
(load custom-file)


(provide 'init-custom)
;;; init-custom.el ends here

;;; init-modus-themes.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-custom)
(require 'init-package)

(unless (package-installed-p 'modus-themes)
  (package-install 'modus-themes))
(require 'modus-themes)

(customize-set-variable 'modus-themes-prompts '(bold))

(load-theme 'modus-operandi :no-confirm)

(provide 'init-modus-themes)
;;; init-modus-themes.el ends here

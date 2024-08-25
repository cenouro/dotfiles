;;; init-corfu.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'init-custom)
(require 'init-package)

(unless (package-installed-p 'corfu)
  (package-install 'corfu))
(require 'corfu)
(global-corfu-mode 1)

(customize-set-variable 'tab-always-indent 'complete)

(customize-set-variable 'corfu-auto nil)
(customize-set-variable 'corfu-cycle t)
(customize-set-variable 'corfu-preview-current nil)
(customize-set-variable 'corfu-quit-at-boundary nil)
(customize-set-variable 'corfu-quit-no-match nil)
(customize-set-variable 'corfu-scroll-margin 3)

(provide 'init-corfu)
;;; init-corfu.el ends here

;;; init-ansible.el ---  -*- lexical-binding: t; -*-

;;; Commentary:
;;

;;; Code:
(with-eval-after-load 'comint
  (let ((ansible-become-prompt-regexp "^BECOME password:[[:space:]]*\\'"))
    (unless (string-match-p (regexp-quote ansible-become-prompt-regexp)
                            comint-password-prompt-regexp)
      (customize-set-variable 'comint-password-prompt-regexp
                              (concat comint-password-prompt-regexp
                                      "\\|"
                                      ansible-become-prompt-regexp)
                              "Make Emacs prompt for BECOME password."))))


(provide 'init-ansible)
;;; init-ansible.el ends here

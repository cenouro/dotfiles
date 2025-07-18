;;; init-ruby.el ---  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(add-hook 'ruby-mode-hook #'inf-ruby-minor-mode)
(define-key ruby-mode-map (kbd "C-c ?") #'yari)
(add-to-list 'auto-mode-alist '("/\\.irbrc\\'" . ruby-mode))


(with-eval-after-load 'compile
  (add-hook 'ruby-mode-hook
            #'(lambda () (setq-local compile-command "bundle exec rake test")))
  (add-to-list 'compilation-error-regexp-alist-alist
               '(rails-minitest-failure "\\[\\(.*?.rb\\):\\([0-9]+\\)\\]:$" 1 2))
  (add-to-list 'compilation-error-regexp-alist 'rails-minitest-failure)
  (font-lock-add-keywords 'compilation-mode
                          '(("^Expected" . 'compilation-error)
                            ("false\\|true\\|truthy\\|nil"
                             . 'font-lock-constant-face))))


(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(ruby-mode . ("bundle" "exec"
                              ,(if (executable-find "watchman")
                                   "srb tc --lsp"
                                 "srb tc --lsp --disable-watchman")))))


(define-skeleton minitest-skeleton
  "Skeleton for *_test.rb files."
  nil
  "require 'minitest/autorun'" \n \n
  "class Test"
  (replace-regexp-in-string (rx (or "-" (seq "_" (? "test.rb"))))
                            "" (capitalize (buffer-name)))
  " < Minitest::Test" \n
  "def test_" _ > \n
  "end" > \n
  "end" > "\n")


(provide 'init-ruby)
;;; init-ruby.el ends here

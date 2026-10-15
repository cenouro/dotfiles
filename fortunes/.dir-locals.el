;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

((fundamental-mode
  . ((eval
      . (progn
          ;; Function that uses strfile to generate the pertinent .dat
          ;; file for fortune. A lambda is used instead of a function
          ;; because of security concerns: a function could be
          ;; redefined. Furthermore, using the eval form is convenient
          ;; because it allows the choice of "trust now and always",
          ;; whereas using (after-save-hook . ...) form is considered
          ;; always risky by Emacs.
          (add-hook 'after-save-hook
                    (lambda ()
                      (let ((fortune-file buffer-file-name)
                            (output-file  (concat buffer-file-name ".dat")))
                        (with-temp-buffer
                          (shell-command
                           (format "strfile -s %s %s" fortune-file output-file)
                           t shell-command-buffer-name))))
                    0 t)
          ;; add-hook (used above) adds t to local hooks; the
          ;; following line removes such t.
          (remove-hook 'after-save-hook t t))))))

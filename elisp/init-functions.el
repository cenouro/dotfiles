;;; init-functions.el --- my ad-hoc defuns  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; The purpose of this files is to hold ALL my custom functions.
;;
;; Why put every function here? Because deciding how to divide
;; functions into separate files is too cumbersome. Think of this file
;; as being analogous to `init.el', the difference being that
;; `init.el' contains configurations, whereas this file contains only
;; functions.
;;
;; Now, here are the rules regarding the organization and quality of
;; this file:
;;
;;   * this file requires no organization whatsoever because
;;     navigation can easily be done through `imenu';
;;   * in fact, `imenu' can even handle functions that have been
;;     implemented inside `with-eval-after-load', so don't hesitate
;;     and use put code inside `with-eval-after-load' when necessary;
;;   * strive for perfection in docstrings
;;

;;; Code:
;;

(provide 'init-functions)
;;; init-functions.el ends here

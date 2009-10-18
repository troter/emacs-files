;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;; (auto-install-batch "auto-complete development version")
(when (require 'auto-complete nil t)
  (require 'auto-complete-yasnippet)
  (global-auto-complete-mode t)

  (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))

  ;; Use M-n/M-p to select candidates
  (define-key ac-complete-mode-map [(meta n)] 'ac-next)
  (define-key ac-complete-mode-map [(meta p)] 'ac-previous)

  ;; Completion by TAB
  (define-key ac-complete-mode-map [(tab)] 'ac-complete)
  (define-key ac-complete-mode-map [(return)] nil)

  (defun-eval-after-load 'anything
    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/ac-anything.el")
    (require 'ac-anything)
    (define-key ac-complete-mode-map [(meta i)] 'ac-complete-with-anything))
)

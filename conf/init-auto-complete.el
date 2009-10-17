;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;; (auto-install-batch "auto-complete development version")
(when (require 'auto-complete nil t)
  (require 'auto-complete-yasnippet)
  (global-auto-complete-mode t)

  (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))
;  (set-default 'ac-sources '(ac-source-yasnippet))

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

  (defun-eval-after-load 'ruby-mode
    (defun-add-hook 'ruby-mode-hook
      (when (require 'rcodetools nil t)
        (require 'auto-complete-ruby)
        (make-local-variable 'ac-omni-completion-sources)
        (setq ac-omni-completion-sources
              '(("\\.\\=" . (ac-source-rcodetools)))))))

  (defun-add-hook 'emacs-lisp-mode-hook
    (require 'auto-complete-emacs-lisp)
    (make-local-variable 'ac-omni-completion-sources)
    (setq ac-omni-completion-sources
          '(("\\.\\=" . (ac-source-emacs-lisp-features)))))
)

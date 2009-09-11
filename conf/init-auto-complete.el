;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;; (auto-install-batch "auto-complete development version")
(when (require 'auto-complete nil t)
  (global-auto-complete-mode t)
  (add-hook 'ruby-mode-hook
            (lambda ()
              (when (require 'rcodetools nil t)
                (require 'auto-complete-ruby)
                (make-local-variable 'ac-omni-completion-sources)
                (setq ac-omni-completion-sources
                      '(("\\.\\=" . (ac-source-rcodetools)))))))
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (require 'auto-complete-emacs-lisp)
              (make-local-variable 'ac-omni-completion-sources)
              (setq ac-omni-completion-sources
                    '(("\\.\\=" . (ac-source-emacs-lisp-features))))))
)

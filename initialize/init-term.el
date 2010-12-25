;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; term
;; ----
(defun-add-hook 'term-mode-hook
  (define-key term-raw-map "\C-z"
    (lookup-key (current-global-map) "\C-z"))
  (define-key term-raw-map "\C-p" 'previous-line)
  (define-key term-raw-map "\C-n" 'next-line)
  (term-set-escape-char ?\C-x))

;; shell
;; -----
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

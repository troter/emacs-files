;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(require 'hideshow)
(hs-hide-level 2)
(setq hs-hide-comments-when-hiding-all nil)
(setq search-invisivle nil)

(defun ttn-hs-hide-level-1 ()
  (hs-hide-level 1)
  (forward-sexp 1))
(setq hs-hide-all-non-comment-function 'ttn-hs-hide-level-1)

(setq hs-set-up-overlay
      (defun my-display-code-line-counts (ov)
        (when (eq 'code (overlay-get ov 'hs))
          (overlay-put ov 'display
                       (propertize
                        (format " ... <%d>"
                                (count-lines (overlay-start ov)
                                             (overlay-end ov)))
                        'face 'font-lock-type-face)))))
(defvar hs-toggle-hiding-all-flag nil)
(defun hs-toggle-hiding-all ()
  (if hs-toggle-hiding-all-flag
      (hs-hide-all)
    (hs-show-all))
  (setq hs-toggle-hiding-all-flag (not hs-toggle-hiding-all-flag)))

(define-key hs-minor-mode-map [(Control Meta i)] 'hs-toggle-hiding)
(define-key hs-minor-mode-map [(Control Meta y)] 'hs-toggle-hiding-all)

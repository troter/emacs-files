;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(require 'acp)

;; refer: http://d.hatena.ne.jp/kitokitoki/20090823
(add-hook 'emacs-lisp-mode-hook 'acp-mode)
(add-hook 'lisp-mode-hook 'acp-mode)
(add-hook 'scheme-mode-hook 'acp-mode)

(setq acp-paren-alist
  '((?( . ?))
    (?[ . ?])))

(setq acp-insertion-functions
   '((mark-active . acp-surround-with-paren)
     ((thing-at-point 'symbol) . acp-surround-symbol-with-paren)
     (t . acp-insert-paren)))

(defun acp-surround-symbol-with-paren (n)
  (save-excursion
    (save-restriction
      (narrow-to-region (car (bounds-of-thing-at-point 'symbol)) (cdr (bounds-of-thing-at-point 'symbol)))
      (goto-char (point-min))
      (insert-char (car (acp-current-pair)) n)
      (goto-char (point-max))
      (insert-char (cdr (acp-current-pair)) n))))

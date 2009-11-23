;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(load "elscreen" "ElScreen" t)
(require 'elscreen-dired)
(define-key elscreen-map "\C-z" 'suspend-emacs)
(defun-eval-after-load 'anything-config
  (define-key elscreen-map "\C-o" '(lambda () (interactive) (anything 'anything-c-source-elscreen))))

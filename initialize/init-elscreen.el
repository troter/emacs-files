;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(defun-add-hook 'after-init-hook
  (when (load-safe "elscreen")
    (require 'elscreen-dired)
    (define-key elscreen-map "\C-z" 'suspend-emacs)
    (defun-eval-after-load 'anything-config
    (define-key elscreen-map "\C-o" '(lambda () (interactive) (anything 'anything-c-source-elscreen))))))


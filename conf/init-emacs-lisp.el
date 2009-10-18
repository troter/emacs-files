;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
(defun-add-hook 'emacs-lisp-mode-hook
  (setq indent-tabs-mode nil))

(defun-eval-after-load 'auto-complete
  (require 'auto-complete-emacs-lisp)
  (ac-emacs-lisp-init))

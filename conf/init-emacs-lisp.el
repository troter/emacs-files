;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
(defun-add-hook 'emacs-lisp-mode-hook
  (setq indent-tabs-mode nil))

(defun-eval-after-load 'auto-complete-config
  (ac-emacs-lisp-features-initialize))

;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el")
;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/el-mock.el")

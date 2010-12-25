;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
(defun-add-hook 'c-mode-common-hook
  (c-set-style "BSD")
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil)
  (hide-ifdef-mode 1)
  (c-set-offset 'innamespace 0))
(defun-add-hook 'c++-mode-hook
  (c-set-style "BSD")
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil)
  (hide-ifdef-mode 1)
  (c-set-offset 'innamespace 0))

;;(defun-eval-after-load 'auto-complete-config
;;  (ac-c++-keywords-initialize))

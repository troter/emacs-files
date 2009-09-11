;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
(add-hook 'c-mode-common-hook
          '(lambda ()
             (progn
               (c-set-style "BSD")
               (setq tab-width 4)
               (setq c-basic-offset tab-width)
               (setq indent-tabs-mode nil)
               (hide-ifdef-mode 1)
               (c-set-offset 'innamespace 0))))
(add-hook 'c++-mode-hook
          '(lambda ()
             (progn
               (c-set-style "BSD")
               (setq tab-width 4)
               (setq c-basic-offset tab-width)
               (setq indent-tabs-mode nil)
               (hide-ifdef-mode 1)
               (c-set-offset 'innamespace 0))))

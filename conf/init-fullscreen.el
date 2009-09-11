;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(when carbon-p
  (add-hook 'window-setup-hook
            (lambda ()
	      (setq mac-autohide-menubar-on-maximize t)
              (set-frame-parameter nil 'fullscreen 'fullboth)))
  (when (functionp 'mac-toggle-max-window)
    (global-set-key "\M-\r" 'mac-toggle-max-window)))

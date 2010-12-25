;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(and (and nt-p (not meadow-p)) ;; ntemacs-p
     (functionp #'mw32-ime-initialize)
     (setq default-input-method "MW32-IME")
     (setq-default mw32-ime-mode-line-state-indicator "[--]")
     (setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
     (mw32-ime-initialize)

     (wrap-function-to-control-ime 'y-or-n-p nil nil)
     (wrap-function-to-control-ime 'yes-or-no-p nil nil)
     (wrap-function-to-control-ime 'universal-argument t nil)
     (wrap-function-to-control-ime 'read-string nil nil)
     (wrap-function-to-control-ime 'read-from-minibuffer nil nil)
     (wrap-function-to-control-ime 'read-key-sequence nil nil)
     (wrap-function-to-control-ime 'map-y-or-n-p nil nil)
     (wrap-function-to-control-ime 'read-passwd t t) ; don't work as we expect.

     (add-hook 'mw32-ime-on-hook
	       (function (lambda () (set-cursor-color "blue"))))
     (add-hook 'mw32-ime-off-hook
	       (function (lambda () (set-cursor-color "black"))))
     (add-hook 'minibuffer-setup-hook
	       (function (lambda ()
			   (if (fep-get-mode)
			       (set-cursor-color "blue")
			     (set-cursor-color "black"))))))

(and linux-p
     bsd-p
     ;; Anthy
     ;;    CTRL-\で入力モード切替え
     (locate-library "anthy")
     (load-library "anthy")
     (setq default-input-method "japanese-anthy"))
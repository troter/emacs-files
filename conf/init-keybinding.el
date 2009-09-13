;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;(global-set-key "\C-z" 'undo)                       ;;UNDO
(global-set-key [f1] 'help-for-help)

;;Ctrl-Hでバックスペース
(global-set-key [(control h)] 'backward-delete-char)

;; M-p, M-n でバッファーの移動
(global-set-key [(meta n)] (lambda () (interactive) (other-window)))
(global-set-key [(meta p)] (lambda () (interactive) (other-window -1)))

;; replacement for iswitchb.
(and (require 'anything nil t)
     (global-set-key [(control x) (b)] 'anything-my-for-buffers))

;; replacement for query-query-replace
(global-set-key [(meta %)] 'anything-query-replace-regexp)

;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/key-chord.el")
(when (require 'key-chord nil t)
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.1)
  (setq key-chord-one-keys-delay 0.1)
  ;; don't hijack input method!
  (defadvice toggle-input-method (around toggle-input-method-around activate)
    (let ((input-method-function-save input-method-function))
      ad-do-it
      (setq input-method-function input-method-function-save)))
  ;; keybind
)

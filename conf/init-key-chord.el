;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/key-chord.el")
(when (require 'key-chord nil t)
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.05)
  (setq key-chord-one-keys-delay 0.05)
  ;; don't hijack input method!
  (defadvice toggle-input-method (around toggle-input-method-around activate)
    (let ((input-method-function-save input-method-function))
      ad-do-it
      (setq input-method-function input-method-function-save)))
)

;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;;; (@* "Global set keys")
;; (@* "anything")
(defun-eval-after-load 'anything
  ;; replacement for iswitchb.
  (global-set-key [(control x) (b)] 'anything-for-buffers)
  ;; replacement for kill-buffers.
  ;(global-set-key [(control x) (k)] 'anything-kill-buffers)
  ;; replacement for yank-pop
  (global-set-key [(meta y)] 'anything-show-kill-ring)
  ;; replacement for query-replace-regexp
  (global-set-key [(meta %)] 'anything-query-replace-regexp))

(defun-eval-after-load 'anything-complete
  (global-set-key [(control x) (h)] 'anything-apropos))

(defun-eval-after-load 'descbinds-anything
  (global-set-key [(control h)] 'descbinds-anything))

(defun-eval-after-load 'anything-c-moccur
  ;; buffer
  (global-set-key [(meta o)] 'anything-c-moccur-occur-by-moccur)
  ;; directory
  (global-set-key [(control meta o)] 'anything-c-moccur-dmoccur))

;; (@* "others")
(defun-eval-after-load 'flymake
  (global-set-key [(control c) (d)] 'flymake-display-err-menu-for-current-line))

;(global-set-key "\C-z" 'undo)                       ;;UNDO
(global-set-key [f1] 'help-for-help)

(global-set-key [(control x) (p)] (lambda () (interactive) (other-window -1)))
(global-set-key [(control x) (w)] 'mark-whole-buffer)

(global-set-key [(control x) (control r)] 'reopen-file)
(global-set-key [(control x) (J)] 'open-junk-file)

;;; (@* "key-chord")
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

;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (@* "anything")
(defun-eval-after-load 'anything
  ;;(global-set-key [(control x) (k)] 'anything-kill-buffers) ; kill-buffers
  (global-set-key [(control x) (b)] 'anything-for-buffers)    ; switch-to-buffer
  (global-set-key [(meta y)] 'anything-show-kill-ring)        ; yank-pop
  (global-set-key [(meta %)] 'anything-query-replace-regexp)  ; query-replace-regexp
)

(defun-eval-after-load 'anything-c-moccur
  (global-set-key [(meta o)] 'anything-c-moccur-occur-by-moccur) ; buffer
  (global-set-key [(control meta o)] 'anything-c-moccur-dmoccur) ; directory
)

(defun-eval-after-load 'key-chord
  ;; keybind
  (defun-eval-after-load 'anything-complete
    (key-chord-define-global "ap" 'anything-apropos))
  (defun-eval-after-load 'descbinds-anything
    (key-chord-define-global "df" 'descbinds-anything))
  )

;; (@* "one key")
(defun-eval-after-load 'one-key
  (global-set-key [(control x) (v)] 'one-key-menu-VC))

;; (@* "others")
(defun-eval-after-load 'flymake
  (global-set-key [(control c) (d)] 'flymake-display-err-menu-for-current-line))

;(global-set-key "\C-z" 'undo)                       ;;UNDO
(global-set-key [f1] 'one-key-menu-help)

;; window switch
(global-set-key [(meta \[)] (lambda () (interactive) (other-window -1)))
(global-set-key [(meta \])] (lambda () (interactive) (other-window 1)))

(global-set-key [(control h)] 'backward-delete-char)

(global-set-key [(control x) (control r)] 'reopen-file)
(global-set-key [(control x) (J)] 'open-junk-file)


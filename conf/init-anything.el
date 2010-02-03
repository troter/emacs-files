;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-batch "anything")
;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/descbinds-anything.el")
(when (require 'anything-startup)
  ;; replace completion commands with `anything'
  (anything-read-string-mode 1)

  (setq anything-su-or-sudo "sudo")

  (define-key anything-map [(meta N)] 'anything-next-source)
  (define-key anything-map [(meta P)] 'anything-previous-source)
  (define-key anything-map [end] 'anything-scroll-other-window)
  (define-key anything-map [home] 'anything-scroll-other-window-down)
  (define-key (anything-read-file-name-map) [(meta i)] 'anything-select-action)

  ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/shell-history.el")
  ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/shell-command.el")
  (require 'shell-history)
  (require 'shell-command)
  (shell-command-completion-mode)
  ;; Bind C-o to complete shell history
  (anything-complete-shell-history-setup-key [(control o)])

  ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr.el")
  ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr-config.el")
  (require 'anything-kyr-config)
  ;; Automatically collect symbols by 100 secs
  (anything-lisp-complete-symbol-set-timer 100)

  (defadvice anything-read-buffer
    (around transmissive-keyboard-quit-anything-read-buffer)
    "abort-recursive-edit 時にアクションを行わない"
    (let ((it ad-do-it))
      (if (and (not it)
               (or (not this-command) ;; this-commandがnilの場合がある。。。
                   (eq this-command 'abort-recursive-edit)))
          (keyboard-quit)
        it)))
  (ad-activate 'anything-read-buffer)
  )

;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-batch "anything")
(when (require 'anything)
  (require 'anything-config)
  (require 'anything-match-plugin)
  (setq anything-su-or-sudo "sudo")

  (define-key anything-map [(meta N)] 'anything-next-source)
  (define-key anything-map [(meta P)] 'anything-previous-source)
  (define-key anything-map [end] 'anything-scroll-other-window)
  (define-key anything-map [home] 'anything-scroll-other-window-down)

  (when (featurep 'yasnippet)
    ;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/anything-c-yasnippet/anything-c-yasnippet.el")
    (require 'anything-c-yasnippet)
    (setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
    (global-set-key [(control c) (y)] 'anything-c-yas-complete))

  ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/anything-complete.el")
  (when (require 'anything-complete)
    ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/shell-history.el")
    ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/shell-command.el")
    ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr.el")
    ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr-config.el")
    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/anything-show-completion.el")
    (require 'shell-history)
    (require 'shell-command)
    (shell-command-completion-mode)
    (require 'anything-kyr-config)
    (require 'anything-show-completion)
    ;; Automatically collect symbols by 100 secs
    (anything-lisp-complete-symbol-set-timer 100)
    ;; replace completion commands with `anything'
    (anything-read-string-mode 1)
    ;; Bind C-o to complete shell history
    (anything-complete-shell-history-setup-key [(control o)])
    (define-key (anything-read-file-name-map) [(meta i)] 'anything-select-action))

  ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/descbinds-anything.el")
  (when (require 'descbinds-anything)
    (descbinds-anything-install))
  )

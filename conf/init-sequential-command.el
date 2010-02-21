;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/sequential-command.el")
;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/sequential-command-config.el")
(when (require 'sequential-command-config nil t)
  (sequential-command-setup-keys)

  (define-sequential-command seq-home
    back-to-indentation beginning-of-line beginning-of-buffer seq-return)
  ;;(define-sequential-command seq-end
  ;;  end-of-line end-of-buffer seq-return)
  )

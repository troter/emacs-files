;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/one-key.el")
;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/one-key-config.el")
;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/one-key-default.el")
(when (require 'one-key-default)
  (defun-add-hook 'emacs-startup-hook
    (require 'one-key-config)
    (one-key-default-setup-keys)
    ))

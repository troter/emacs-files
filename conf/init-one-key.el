;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/one-key.el")
;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/one-key-config.el")
;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/one-key-default.el")
(when (autoload-if-found 'one-key-default-setup-keys "one-key-config" "setup one key")
  (require 'one-key-default))

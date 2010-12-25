;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/linkd.el")
(when (require 'linkd nil t)
  (when (file-directory-p linkd-icons-directory)
    (setq linkd-use-icons t))

  (dolist (mode '(emacs-lisp-mode-hook lisp-mode-hook
                  scheme-mode-hook text-mode-hook))
    (add-hook mode 'linkd-mode))

  ;; linkd wiki
  (when (file-directory-p linkd-wiki-directory)
    (global-set-key [(meta f8)]
                  '(lambda () (interactive)
                     (linkd-wiki-find-page "FrontPage"))))
)

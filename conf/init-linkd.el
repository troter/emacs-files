;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/linkd.el")
(when (require 'linkd nil t)

  (when (file-directory-p linkd-icons-directory)
    (setq linkd-use-icons t))

  (dolist (mode '(emacs-lisp-mode lisp-mode scheme-mode text-mode))
    (add-hook mode 'linkd-mode))

  (define-key linkd-map [(control f3)] 'linkd-process-block)
  (define-key linkd-map [(meta \[)] 'linkd-previous-link)
  (define-key linkd-map [(meta \])] 'linkd-next-link)
  (define-key linkd-map [(meta return)] 'linkd-follow-at-point)

  ;; linkd wiki
  (when (file-directory-p linkd-wiki-directory)
    (global-set-key [(meta f8)]
                  '(lambda () (interactive)
                     (linkd-wiki-find-page "FrontPage"))))
)

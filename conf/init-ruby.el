;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(when (and (autoload-if-found 'ruby-mode "ruby-mode" "Mode for editing ruby source file")
           (autoload-if-found 'run-ruby "inf-ruby" "Run an inferior Ruby process")
           (autoload-if-found 'run-ruby "inf-ruby" "Run an inferior Ruby process")
           (require 'ruby-electric nil t))
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
  (setq ruby-deep-indent-paren-style nil)
  (setq ruby-electric-expand-delimiters-list '( ?\{))
  (add-hook 'ruby-mode-hook
        '(lambda ()
           (progn
             (inf-ruby-keys)
             (ruby-electric-mode t)
             (define-key
               ruby-mode-map
               "\C-m"
               'ruby-reindent-then-newline-and-indent)
             ))))

;; ri emacs use fastri
;; gem install fastri
;; (setq ri-ruby-script "/home/takumi/bin/ri-emacs.rb")
;; (load "ri-ruby")

;; rd-mode
;; rd-mode included rdtool
(when (autoload-if-found 'rd-mode "rd-mode" "major mode for ruby document formatter RD" t)
  (add-to-list 'auto-mode-alist '("\\.rd$" . rd-mode)))

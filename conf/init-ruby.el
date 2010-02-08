;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(require 'rinari)
(when (autoload-if-found 'ruby-mode "ruby-mode" "Mode for editing ruby source file")
  ;;(autoload-if-found 'run-ruby "inf-ruby" "Run an inferior Ruby process")
  (require 'ruby-electric nil t)

  (dolist (regexp '("\\.rb$" "Rakefile" "\\.rake$"))
    (add-to-list 'auto-mode-alist (cons regexp 'ruby-mode)))

  (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
  (setq ruby-deep-indent-paren-style nil)
  (setq ruby-electric-expand-delimiters-list '( ?\{))

  (when (require 'hideshow)
    (add-to-list
     'hs-special-modes-alist
     '(ruby-mode "class\\|module\\|def\\|if\\|unless\\|case\\|while\\|until\\|for\\|begin\\|do" "end" "#" ruby-end-of-block nil)))

  (defun-add-hook 'ruby-mode-hook
    (exec-if-bound (inf-ruby-keys))
    (exec-if-bound (ruby-electric-mode t))
    (when (fboundp 'ruby-reindent-then-newline-and-indent)
      (define-key ruby-mode-map [(control m)]
        'ruby-reindent-then-newline-and-indent))
    )

  (defun-eval-after-load 'auto-complete-config
    (ac-rcodetools-initialize))
)

;; (auto-install-from-emacswiki "anything-rurima.el")
(let ((rurima.e (expand-file-name "misc/rubydoc/rurema.e" base-directory)))
  (when (require 'anything-rurima nil t)
    (setq anything-rurima-index-file rurima.e)))

;; ri emacs use fastri
;; gem install fastri
(when (and (executable-find "rdoc")
             (executable-find "ri"))
  (let ((ri-emacs (expand-file-name "ri-emacs/ri-emacs.rb" plugins-directory))
        (ri-ruby-el (expand-file-name "ri-emacs/ri-ruby.el" plugins-directory)))
    (setq ri-ruby-script ri-emacs)
    (autoload 'ri ri-ruby-el nil t)))

;; rd-mode
;; rd-mode included rdtool
(when (autoload-if-found 'rd-mode "rd-mode" "major mode for ruby document formatter RD" t)
  (add-to-list 'auto-mode-alist '("\\.rd$" . rd-mode)))

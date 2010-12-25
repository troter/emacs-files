;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(when (autoload-if-found 'php-mode "php-mode" "Major mode for editing PHP code.")
  (add-to-list 'auto-mode-alist '("\\.php[s34]?\\'" . php-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . php-mode))
  (add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))
  (setq php-manual-url "http://www.php.net/manual/ja/")

  ;; setup php-completion
  (defun-add-hook 'php-mode-hook
    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/php-completion.el")
    (require 'php-completion)
    (php-completion-mode t)

    ;; with anything
    (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)

    ;; with auto-complete
    (when (require 'auto-complete nil t)
      (make-variable-buffer-local 'ac-sources)
      (add-to-list 'ac-sources 'ac-source-php-completion-patial)
      (auto-complete-mode t))))

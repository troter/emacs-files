;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-from-url "http://github.com/imakado/emacs-smartchr/raw/master/smartchr.el")
(require 'smartchr)
(global-set-key (kbd "=") (smartchr '("=" " = " " == " " === ")))
(global-set-key (kbd "{")
                (smartchr '("{" "{ `!!' }" "{ \"`!!'\" }")))
(global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))

(defun ik:insert-eol (s)
  (interactive)
  (lexical-let ((s s))
    (smartchr-make-struct
     :insert-fn (lambda ()
                  (save-excursion
                    (goto-char (point-at-eol))
                    (when (not (string= (char-to-string (preceding-char)) s))
                      (insert s))))
     :cleanup-fn (lambda ()
                   (save-excursion
                     (goto-char (point-at-eol))
                     (delete-backward-char (length s)))))))

(defun ik:insert-semicolon-eol ()
  (ik:insert-eol ";"))

(global-set-key (kbd "j")
                  (smartchr '("j" ik:insert-semicolon-eol)))

(defun-eval-after-load 'php-mode
  (defun-add-hook 'php-mode-hook
    (define-key php-mode-map (kbd "<")
      (smartchr '("<" "<?php" "<?php\n`!!'\n?>")))
    (define-key php-mode-map (kbd "A")
      (smartchr '("A" "array(`!!')")))
    (define-key php-mode-map (kbd "D")
      (smartchr '("D" "var_dump(`!!')" "Zend_Dump::debug(`!!')")))
    (define-key php-mode-map (kbd "P")
      (smartchr '("P" "protected" "public" "private")))
    (define-key php-mode-map (kbd "T")
      (smartchr '("T" "$this->" "")))
    ))

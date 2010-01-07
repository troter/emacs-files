;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-from-url "http://github.com/imakado/emacs-smartchr/raw/master/smartchr.el")
(require 'smartchr)
(global-set-key (kbd "=") (smartchr '("=" " = " " == " " === ")))
(global-set-key (kbd "{")
                (smartchr '("{" "{ `!!' }" "{ \"`!!'\" }")))
(global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))

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

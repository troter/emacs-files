;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; http://www.bookshelf.jp/soft/meadow_16.html#SEC155
;; <Number>というsuffixを<Parent Directory>にする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;;; misc
(transient-mark-mode t) ;; show mark region
(show-paren-mode t)
(setq visible-bell t) ;;警告音を消す

(setq inhibit-startup-message t)
(auto-compression-mode t) ;;日本語infoの文字化け防止
(setq system-uses-terminfo nil)
(setq require-final-newline t)
;; (setq-default truncate-lines t)
;; (setq make-backup-files nil)                       ;バックアップファイルを作成しない
;; (setq kill-whole-line t)                           ;カーソルが行頭にある場合も行全体を削除

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; (auto-install-from-url "http://stud4.tuwien.ac.at/~e0225855/linum/linum.el")
(when emacs22-p
  (require 'linum))

;; protbuf
;; (auto-install-from-url "http://www.splode.com/~friedman/software/emacs-lisp/src/protbuf.el")
;; (require 'protbuf) 

;; Auto save buffers enhanced
;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/auto-save-buffers-enhanced/trunk/auto-save-buffers-enhanced.el" )
;; (require 'auto-save-buffers-enhanced)
;; (auto-save-buffers-enhanced-include-only-checkout-path t)
;; (auto-save-buffers-enhanced t)
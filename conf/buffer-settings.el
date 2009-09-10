;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; buffer-setting.el --- setup buffer utility

;; color-moccur
;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/color-moccur.el")
;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/moccur-edit.el")
(require 'color-moccur)
(require 'moccur-edit)

;; http://www.bookshelf.jp/soft/meadow_16.html#SEC155
;; <Number>というsuffixを<Parent Directory>にする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; iswitch buffers
(iswitchb-mode 1)
(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )

(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

;;(defvar dired-directory nil)
(defadvice iswitchb-completions (after
                                 iswitchb-completions-with-file-name
                                 activate)
  "選択してるときにファイル名とかを出してみる。"
  (when iswitchb-matches
    (save-excursion
      (set-buffer (car iswitchb-matches))
      (setq ad-return-value
            (concat ad-return-value
                    "\n"
                    (cond ((buffer-file-name)
                           (concat "file: "
                                   (expand-file-name (buffer-file-name))))
                          ((eq major-mode 'dired-mode)
                           (concat "directory: "
                                   (expand-file-name dired-directory)))
                          (t
                           (concat "mode: " mode-name " Mode"))))))))

;; protbuf
;; (auto-install-from-url "http://www.splode.com/~friedman/software/emacs-lisp/src/protbuf.el")
;; (require 'protbuf) 

;; Auto save buffers enhanced
;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/auto-save-buffers-enhanced/trunk/auto-save-buffers-enhanced.el" )
;; (require 'auto-save-buffers-enhanced)
;; (auto-save-buffers-enhanced-include-only-checkout-path t)
;; (auto-save-buffers-enhanced t)

;;; buffer-setting.el ends here

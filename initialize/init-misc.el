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

(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))

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

;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/recentf-ext.el")
(require 'recentf-ext)

;; minibufferの内容を保持
;; ref: http://d.hatena.ne.jp/rubikitch/20091216/minibuffer
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

;; (auto-install-from-url "http://gist.github.com/raw/301447/a9d4a2202e695f950076fbec6fd6fc9407774b6a/undo-tree.el")
(require 'undo-tree)
(global-undo-tree-mode)

;; http://www.fan.gr.jp/~ring/Meadow/meadow.html#ys:no-kill-new-duplicates
(defadvice kill-new (before ys:no-kill-new-duplicates activate)
  (setq kill-ring (delete (ad-get-arg 0) kill-ring)))


;; org-remember
(org-remember-insinuate)
(setq org-directory "~/Dropbox/memo/")
(setq org-default-notes-file (concat org-directory "note.org"))
(setq org-remember-templates
      '(("Todo" ?t "** TODO %? %T\n   %i\n   %a" nil "Inbox")
        ("Bug" ?b "** TODO %?   :bug: %T\n   %i\n   %a" nil "Inbox")
        ("Conference" ?c "** %? %T\n   %i" nil "Conference minutes")
        ("Idea" ?i "** %? %T\n   %i\n   %a" nil "New Ideas")
        ("Note" ?n "** %? %T\n   %i\n   %a" nil "Note")
        ))

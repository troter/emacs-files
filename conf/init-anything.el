;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-batch "anything")
(when (require 'anything)
  (require 'anything-config)
  (require 'anything-match-plugin)

  ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/ac-anything.el")
  (require 'ac-anything)
  (define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)

  (when (featurep 'yasnippet)
    ;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/anything-c-yasnippet/anything-c-yasnippet.el")
    (require 'anything-c-yasnippet)
    (setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
    (global-set-key (kbd "C-c y") 'anything-c-yas-complete))

  ;; candidates-file  plug-in
  (defun anything-compile-source--candidates-file (source)
    (if (assoc-default 'candidates-file source)
        `((init acf-init
                ,@(let ((orig-init (assoc-default 'init source)))
                    (cond ((null orig-init) nil)
                          ((functionp orig-init) (list orig-init))
                          (t orig-init))))
          (candidates-in-buffer)
          ,@source)
      source))
  (add-to-list 'anything-compile-source-functions 'anything-compile-source--candidates-file)

  (defun acf-init ()
    (destructuring-bind (file &optional updating)
        (anything-mklist (anything-attr 'candidates-file))
      (with-current-buffer (anything-candidate-buffer (find-file-noselect file))
        (when updating
          (buffer-disable-undo)
          (font-lock-mode -1)
          (auto-revert-mode 1)))))

  (defvar anything-c-source-home-directory
    '((name . "Home directory")
      ;; /log/home.filelist にホームディレクトリのファイル名が1行につきひとつ格納されている
      (candidates-file "/log/home.filelist" updating)
      (requires-pattern . 5)
      (candidate-number-limit . 20)
      (type . file)))

  (defvar anything-c-source-find-library
    '((name . "Elisp libraries")
      ;; これは全Emacs Lispファイル
      (candidates-file "/log/elisp.filelist" updating)
      (requires-pattern . 4)
      (type . file)
      (major-mode emacs-lisp-mode)))

  (setq anything-sources
        '(anything-c-source-buffers+
          anything-c-source-recentf
          anything-c-source-files-in-current-dir
;;          anything-c-source-home-directory
;;          anything-c-source-locate
          anything-c-source-buffer-not-found
          anything-c-source-colors
          anything-c-source-man-pages
          anything-c-source-emacs-commands
          anything-c-source-emacs-functions
          anything-c-source-calculation-result
          ))

  (defun anything-my-for-buffers ()
    (interactive)
    (anything-other-buffer
     '(anything-c-source-buffers+
       anything-c-source-files-in-current-dir
       anything-c-source-buffer-not-found)
     "anything for buffers"))
)
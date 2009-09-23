;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; (auto-install-batch "anything")

(when (require 'anything)
  (require 'anything-config)
  (require 'anything-match-plugin)
  (setq anything-su-or-sudo "sudo")

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
    "Preconfigured `anything' for buffers."
    (interactive)
    (anything-other-buffer
     '(anything-c-source-buffers+
       anything-c-source-buffer-not-found
       anything-c-source-file-name-history)
     "anything for buffers"))

  ;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
  (when (require 'anything-c-moccur)
    ;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
    (setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
          anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
          anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
          anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

    ;;; キーバインドの割当(好みに合わせて設定してください)
    (global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
    (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
    (add-hook 'dired-mode-hook ;dired
              '(lambda ()
                 (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur))))

  ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/anything-complete.el")
  (when (require 'anything-complete)
    ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/shell-history.el")
    ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/shell-command.el")
    ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr.el")
    ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr-config.el")
    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/anything-show-completion.el")
    (require 'shell-history)
    (require 'shell-command)
    (shell-command-completion-mode)
    (require 'anything-kyr-config)
    (require 'anything-show-completion)
    ;; Automatically collect symbols by 100 secs
    (anything-lisp-complete-symbol-set-timer 200)
    ;; replace completion commands with `anything'
    (anything-read-string-mode 1)
    ;; Bind C-o to complete shell history
    (anything-complete-shell-history-setup-key "\C-o")
    
    (define-key (anything-read-file-name-map) "\C-i" 'anything-select-action)
    )

  ;; replacement for iswitchb.
  (global-set-key [(control x) (b)] 'anything-my-for-buffers)
  ;; replacement for yank-pop
  (global-set-key [(meta y)] 'anything-show-kill-ring)
  ;; replacement for query-query-replace
  (global-set-key [(meta %)] 'anything-query-replace-regexp)
  )

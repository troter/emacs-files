;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(when (require 'yasnippet nil t)
  ;; refer: http://d.hatena.ne.jp/antipop/20080321/1206090430
  (setq yas/use-menu nil)

  (require 'dropdown-list)
  (setq yas/prompt-functions '(yas/dropdown-prompt))

  (add-to-list 'yas/known-modes 'php-mode)

  (setq yas/root-directory
        (expand-file-name "yasnippet-0.6.1c/snippets" plugins-directory))

  ;; 自分用スニペットディレクトリ(リストで複数指定可)
  (defvar my-snippet-directories
    (list
     ;; http://apgwoz.com/hacks/yasnippet-php-mode.tar.gz
     (expand-file-name "snippets/yasnippet-php-mode" base-directory)
     ;; private
     (expand-file-name "snippets/private" base-directory)))

  ;; yasnippet公式提供のものと、自分用カスタマイズスニペットをロード同名
  ;; のスニペットが複数ある場合、あとから読みこんだ自分用のものが優先され
  ;; る。また、スニペットを変更、追加した場合、このコマンドを実行すること
  ;; で、変更・追加が反映される。
  (defun yas/load-all-directories ()
    (interactive)
    (yas/reload-all)
    (mapc 'yas/load-directory-1 my-snippet-directories))

  ;; yasnippet展開中はflymakeを無効にする
  (defvar flymake-is-active-flag nil)

  (defadvice yas/expand-snippet
    (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
    (setq flymake-is-active-flag
          (or flymake-is-active-flag
              (assoc-default 'flymake-mode (buffer-local-variables))))
    (when flymake-is-active-flag
      (flymake-mode-off)))

  (defun-add-hook 'yas/after-exit-snippet-hook
    (when flymake-is-active-flag
      (flymake-mode-on)
      (setq flymake-is-active-flag nil)))

  (defun-eval-after-load 'anything
    ;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/anything-c-yasnippet/anything-c-yasnippet.el")
    (require 'anything-c-yasnippet)
    (setq anything-c-yas-display-key-on-candidate t)
    (setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
    (global-set-key [(control c) (y)] 'anything-c-yas-complete))

  ;; yasnipet use via auto-complete
  (setq yas/trigger-key nil)
  (yas/trigger-key-reload "TAB")

  (yas/initialize)
  (yas/load-all-directories)
)

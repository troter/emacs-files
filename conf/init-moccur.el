;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; color-moccur
;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/color-moccur.el")
;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/moccur-edit.el")
(progn
  (require 'color-moccur)
  (require 'moccur-edit)
  (setq moccur-split-word t))
;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))

(eval-after-load "anything"
  '(progn
     ;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
     (require 'anything-c-moccur nil t)
     ;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
     (setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
           anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
           anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
           anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする
     ;;; キーバインドの割当(好みに合わせて設定してください)
     (global-set-key [(meta o)] 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
     (global-set-key [(control meta o)] 'anything-c-moccur-dmoccur) ;ディレクトリ
     (add-hook 'dired-mode-hook ;dired
               '(lambda ()
                  (local-set-key [(O)] 'anything-c-moccur-dired-do-moccur-by-moccur)))))

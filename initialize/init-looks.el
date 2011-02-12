;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(when window-system
  (add-to-list 'default-frame-alist '(foreground-color . "azure3"))
  (add-to-list 'default-frame-alist '(background-color . "black"))
  (add-to-list 'default-frame-alist '(cursor-color . "white"))
  (add-to-list 'default-frame-alist '(mouse-color . "white"))
  (set-face-background 'modeline "grey10")
  (set-face-foreground 'modeline "SkyBlue")
  (set-face-background 'highlight "grey10")
  (set-face-foreground 'highlight "red")
  (set-face-background 'region "LightSteelBlue1")
  (set-face-foreground 'mode-line-inactive "gray30")
  (set-face-background 'mode-line-inactive "gray85")

  (add-to-list 'default-frame-alist '(alpha . 92))
  (set-frame-parameter nil 'alpha '(85 50))

  (set-scroll-bar-mode 'right) ;;スクロールバーを右に表示
  (tool-bar-mode -1)           ;;ツールバーを消す
)

(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-arjen))

(and ; hl-line
 (defface hlline-face
   '((((class color)
       (background dark))
       ;;(:background "dark state gray"))
      (:background "gray10"
                   :underline "gray24"))
     (((class color)
       (background light))
      (:background "ForestGreen"
                   :underline nil))
     (t ()))
   "*Face used by hl-line.")
 (setq hl-line-face 'hlline-face)
 ;;(setq hl-line-face 'underline)
 (global-hl-line-mode t))

(and ; mode line
 (setq line-number-mode t)   ;;カーソルのある行番号を表示
 (setq column-number-mode t) ;;カーソルのある列番号を表示
 (display-time)              ;;時計を表示
)

(and ; window
 (menu-bar-mode -1)       ;;メニューバーを消す
 (setq frame-title-format ;;フレームのタイトル指定
       (concat "%b - emacs@" system-name))
)


(and ; mouse 
 (when (and windows-p window-system)
   ;;ホイールマウス
   (mouse-wheel-mode t)
   ;; マウスカーソルを消す
   (setq w32-hide-mouse-on-key t)
   (setq w32-hide-mouse-timeout 5000)))

;; refer :http://openlab.dino.co.jp/wp-content/uploads/2008/08/dotemacs-jaspace.txt
;; (auto-install-from-url "http://homepage3.nifty.com/satomii/software/jaspace.el")
;; タブ, 全角スペース、改行直前の半角スペースを表示する
(when (require 'jaspace nil t)
  (when (boundp 'jaspace-modes)
    (setq jaspace-modes (append jaspace-modes
                                (list 'php-mode
                                      'yaml-mode
                                      'javascript-mode
                                      'ruby-mode
                                      'text-mode
                                      'fundamental-mode))))
  (when (boundp 'jaspace-alternate-jaspace-string)
    (setq jaspace-alternate-jaspace-string "□"))
  (when (boundp 'jaspace-highlight-tabs)
    (setq jaspace-highlight-tabs ?^))
  (when (boundp 'jaspace-alternate-eol-string)
    (setq jaspace-alternate-eol-string nil))
  (add-hook 'jaspace-mode-off-hook
            (lambda()
              (when (boundp 'show-trailing-whitespace)
                (setq show-trailing-whitespace nil))))
  (add-hook 'jaspace-mode-hook
            (lambda()
              (progn
                (when (boundp 'show-trailing-whitespace)
                  (setq show-trailing-whitespace t))
                (face-spec-set 'jaspace-highlight-jaspace-face
                               '((((class color) (background light))
                                  (:foreground "blue"))
                                 (t (:foreground "green"))))
                (face-spec-set 'jaspace-highlight-tab-face
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))
                (face-spec-set 'trailing-whitespace
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))))))

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

  (and (require 'color-theme nil t)
       (color-theme-initialize)
       (color-theme-arjen))
  
  (add-to-list 'default-frame-alist '(alpha . 85))
  (set-frame-parameter nil 'alpha '(85 50))

  (set-scroll-bar-mode 'right) ;;スクロールバーを右に表示
  (tool-bar-mode -1)           ;;ツールバーを消す
)

(and ; hl-line
 (global-hl-line-mode t)
 (setq hl-line-face 'underline)
 (hl-line-mode 1))

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
 (mouse-wheel-mode t) ;;ホイールマウス
 (when (and windows-p window-system)
   ;; マウスカーソルを消す
   (setq w32-hide-mouse-on-key t)
   (setq w32-hide-mouse-timeout 5000)))

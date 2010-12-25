;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(progn
  (member '("utf-8-unix") coding-system-alist)
  (setenv "LANG"
          (or (getenv "LANG") "en_US.UTF-8"))
  (setenv "LC_CTYPE"
          (or (getenv "LC_CTYPE") "ja_JP.UTF-8"))
  (set-language-environment "Japanese")

  (mapc #'prefer-coding-system
        '(shift_jis iso-2022-jp euc-jp utf-8))

  ;; 文脈依存な文字幅問題を解決
  ;; http://www.pqrs.org/tekezo/emacs/doc/wide-character/index.html
  (when (functionp #'utf-translate-cjk-set-unicode-range)
    (utf-translate-cjk-set-unicode-range
     '((#x00a2 . #x00a3)                    ; ¢, £
       (#x00a7 . #x00a8)                    ; §, ¨
       (#x00ac . #x00ac)                    ; ¬
       (#x00b0 . #x00b1)                    ; °, ±
       (#x00b4 . #x00b4)                    ; ´
       (#x00b6 . #x00b6)                    ; ¶
       (#x00d7 . #x00d7)                    ; ×
       (#X00f7 . #x00f7)                    ; ÷
       (#x0370 . #x03ff)                    ; Greek and Coptic
       (#x0400 . #x04FF)                    ; Cyrillic
       (#x2000 . #x206F)                    ; General Punctuation
       (#x2100 . #x214F)                    ; Letterlike Symbols
       (#x2190 . #x21FF)                    ; Arrows
       (#x2200 . #x22FF)                    ; Mathematical Operators
       (#x2300 . #x23FF)                    ; Miscellaneous Technical
       (#x2500 . #x257F)                    ; Box Drawing
       (#x25A0 . #x25FF)                    ; Geometric Shapes
       (#x2600 . #x26FF)                    ; Miscellaneous Symbols
       (#x2e80 . #xd7a3) (#xff00 . #xffef)))))

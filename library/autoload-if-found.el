;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; refer: http://www.sodan.org/~knagano/emacs/dotemacs.html
(defmacro exec-if-bound (sexplist)
  "関数が存在する時だけ実行する。（car の fboundp を調べるだけ）"
  `(if (fboundp (car ',sexplist))
       ,sexplist))
(defmacro defun-add-hook (hookname &rest sexplist)
  "add-hook のエイリアス。引数を関数にパックして hook に追加する。"
  `(add-hook ,hookname (function (lambda () ,@sexplist))))
(defun load-safe (loadlib)
  "安全な load。読み込みに失敗してもそこで止まらない。"
  ;; missing-ok で読んでみて、ダメならこっそり message でも出しておく
  (let ((load-status (load loadlib t)))
    (or load-status (message (format "[load-safe] failed %s" loadlib)))
    load-status))

(defmacro eval-safe (&rest body)
  "安全な評価。評価に失敗してもそこで止まらない。"
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

(defun autoload-if-found (function file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (and (locate-library file)
       (autoload function file docstring interactive type)))
(put 'autoload-if-found 'lisp-indent-function 'defun)

(defmacro defun-eval-after-load (file &rest sexplist)
  "eval-after-load のエイリアス。引数を関数にパックして eval-after-load に追加する。"
  `(eval-after-load ,file (quote (progn ,@sexplist))))

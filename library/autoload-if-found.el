;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; refer: http://www.sodan.org/~knagano/emacs/dotemacs.html
(defun autoload-if-found (function file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (and (locate-library file)
       (autoload function file docstring interactive type)))
(put 'autoload-if-found 'lisp-indent-function 'defun)

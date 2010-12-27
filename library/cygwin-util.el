;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(defun cygpath (path)
  "windowsのpathをcygwinのpathに変換"
  (letf (((symbol-function 'normalize-path)
          (function (lambda (path) (replace-regexp-in-string "\\\\" "/" path))))
         ((symbol-function 'remove-newline)
          (function (lambda (str) (replace-regexp-in-string "[\n\r]" "" str))))
         ((symbol-function 'call-cygpath)
          (function (lambda (path)
            (if (executable-find "cygpath")
                (shell-command-to-string (concat "cygpath" " " path))
              path)))))
    (remove-newline (call-cygpath (normalize-path path)))))



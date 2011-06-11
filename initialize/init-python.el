;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; ref: http://www.emacswiki.org/emacs/ProgrammingWithPythonModeDotEl
;; ref: http://www.emacswiki.org/emacs/PythonProgrammingInEmacs
;; (auto-install-from-url "http://launchpad.net/python-mode/trunk/5.2.0/+download/python-mode.el")
(when (autoload-if-found 'python-mode "python-mode" "Python Mode." t)
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (add-to-list 'interpreter-mode-alist '("python" . python-mode))

  )



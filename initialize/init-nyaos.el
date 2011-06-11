;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(when (and windows-p
           (or cygwin-p
               (not (getenv "SHLVL"))))
  (defun tr:use-nyaos ()
    ;;; WindowsNT に付属の CMD.EXE を使う場合。
    (setq explicit-shell-file-name "CMDPROXY.EXE")
    (setq shell-file-name "CMDPROXY.EXE")
    (setq shell-command-switch "\\/c")

    ;;; nyaosを利用する場合 暫定版
    (setq nyaos.exe nil)
    ;;(setq nyaos.exe
    ;;      (or (executable-find "nyaos")
    ;;          (executable-find (concat (getenv "NYAOS_HOME") "\\nyaos"))))
    (when nyaos.exe
      (setq explicit-shell-file-name nyaos.exe
            shell-file-name explicit-shell-file-name
            shell-command-switch ""
            explicit-nyaos.exe-args '()
            shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.,:()-")
      )))

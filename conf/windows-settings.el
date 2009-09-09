;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; windows-setting.el ---

(when windows-p
  ;; argument-editing の設定
  (when (require 'mw32script nil t)
    (mw32script-init)
    (setq exec-suffix-list '(".exe" ".sh" ".pl"))
    (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.:()-"))
  ;; cygwin-mount
  ;; (auto-install-from-emacswiki "cygwin-mount")
  (setq cygwin-mount-cygwin-bin-directory
        (concat (getenv "windir") "\\..\\" "cygwin\\bin"))
  (when (require 'cygwin-mount)
    (cygwin-mount-activate)
    )
)

;;; windows-setting.el ends here

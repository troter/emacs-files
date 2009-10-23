;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(when windows-p
  (setq explicit-shell-file-name
        (cond ((executable-find "zsh") "zsh")
              ((executable-find "bash") "bash")
              (t "sh"))
        shell-file-name explicit-shell-file-name
        shell-command-switch "-c"
        ;; drive letter completion on shell-mode.
        shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.,:()-")

  ;; cygwin-mount
  (setq cygwin-mount-cygwin-bin-directory
        (concat (getenv "windir") "\\..\\" "cygwin\\bin"))
  ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/cygwin-mount.el")
  (require 'cygwin-mount)
  (cygwin-mount-activate)

  ;; argument-editing の設定
  (when (require 'mw32script nil t)
    (mw32script-init)
    (setq exec-suffix-list '(".exe" ".sh" ".pl")))

  ;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/emacs/download/w32-symlinks.el")
  (require 'ls-lisp)
  (require 'w32-symlinks)
  ;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=findfile%20symlink
  (defadvice minibuffer-complete
    (before expand-symlinks activate)
    (let ((file (expand-file-name
                 (buffer-substring-no-properties
                  (line-beginning-position)
                  (line-end-position)))))
      (when (string-match ".lnk$" file)
        (delete-region
         (line-beginning-position)
         (line-end-position))
        (if (file-directory-p
             (ls-lisp-parse-symlink file))
            (insert
             (concat
              (ls-lisp-parse-symlink file) "/"))
          (insert (ls-lisp-parse-symlink file))))))

  (when meadow-p (cd "~"))
)

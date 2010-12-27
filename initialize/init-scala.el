;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(block "scala-setting"
  (setq scala-home (getenv "SCALA_HOME"))
  (unless scala-home (return))
  (setq scala-plugins-directory
        (expand-file-name "misc/scala-tool-support/emacs" (cygpath scala-home)))
  (when (file-exists-p scala-plugins-directory)
    (setq load-path (merge-path-list load-path (list scala-plugins-directory)))
    (require 'scala-mode-auto)))

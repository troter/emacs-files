;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(defvar tr-memo-file "~/Dropbox/memo/memo.org")
(defvar dropbox-directory "~/Dropbox/")

(defun dropbox ()
  (interactive)
  (with-temp-buffer
    (cd dropbox-directory)
    (anything-find-file)))

(defun open-memo-file ()
  (interactive)
    (find-file-other-window tr-memo-file))



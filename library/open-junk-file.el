;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; refer: http://d.hatena.ne.jp/rubikitch/20080923/1222104034

(defvar junk-file-directory "~/Dropbox/memo/junk")

(defun open-junk-file ()
  (interactive)
  (let* ((file (expand-file-name
                (format-time-string
                 "%Y/%m/%Y-%m-%d-%H%M%S." (current-time))
                junk-file-directory))
         (dir (file-name-directory file)))
    (make-directory dir t)
    (find-file-other-window (read-string "Junk Code: " file))))

(defun junk-file-dired ()
  (interactive)
  (find-lisp-find-dired junk-file-directory ".*"))

(eval-after-load "color-moccur"
  '(progn
     (defun junk-file-moccur-grep-find (inputs)
       (interactive
        (list (moccur-grep-read-regexp moccur-grep-default-mask)))
       (moccur-grep-find junk-file-directory inputs))
     ))

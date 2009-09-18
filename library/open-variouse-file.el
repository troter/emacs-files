;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

(defun open-directory-with-anything-find-file (dir)
  (let ((default-directory dir))
    (if (commandp 'anything-find-file)
        (anything-find-file)
      (find-file default-directory))))

;; open user init files.
(defun open-init-file ()
  (interactive)
  (find-file-other-window user-init-file))

(defun open-base-directory ()
  (interactive)
  (open-directory-with-anything-find-file base-directory))

(defun open-conf-directory ()
  (interactive)
  (open-directory-with-anything-find-file conf-directory))

(defun open-libraries-directory ()
  (interactive)
  (open-directory-with-anything-find-file libraries-directory))

(defun open-plugins-directory ()
  (interactive)
  (open-directory-with-anything-find-file plugins-directory))

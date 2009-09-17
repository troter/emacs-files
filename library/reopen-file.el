;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=reopen-file
(defun reopen-file ()
  (interactive)
  (let ((file-name (buffer-file-name))
        (old-supersession-threat
         (symbol-function 'ask-user-about-supersession-threat))
        (point (point)))
    (when file-name
      (fset 'ask-user-about-supersession-threat (lambda (fn)))
      (unwind-protect
          (progn
            (erase-buffer)
            (insert-file file-name)
            (set-visited-file-modtime)
            (goto-char point))
        (fset 'ask-user-about-supersession-threat
              old-supersession-threat)))))

(defun reopen-all-files ()
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (reopen-file)
      )))
      

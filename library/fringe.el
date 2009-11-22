;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;; refer: http://d.hatena.ne.jp/buzztaiki/20071023/1193169739
(defun fringe-sample ()
  (interactive)
  (mapcar
   (lambda (bitmap)
     (let ((beg (point)))
       (insert (format "%s\n" bitmap))
       (let* ((s (make-string 1 ?x))
              (ovr (make-overlay beg (point))))
         (put-text-property 0 1 'display (list 'left-fringe bitmap) s)
         (overlay-put ovr 'before-string s)
         (overlay-put ovr 'evaporate t))))
   fringe-bitmaps))

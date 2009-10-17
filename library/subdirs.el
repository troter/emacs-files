;; -*- no-byte-compile: t -*-
;; In load-path, after this directory should come
;; certain of its subdirectories.  Here we specify them.
(setq load-path
      (merge-path-list
       load-path
       (list ;(expand-file-name "hoge" libraries-directory)
             )))
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; End:

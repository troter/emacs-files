;; -*- no-byte-compile: t -*-
;; In load-path, after this directory should come
;; certain of its subdirectories.  Here we specify them.

(defvar package-resource
  '("php-mode-1.5.0" "yasnippet-0.6.1c" "color-theme-6.6.0"
    "elscreen-1.4.6" "elscreen-dired-0.1.0" "apel-10.7"
    "ri-emacs"
    "auto-complete"
    "rinari"))

(setq load-path
      (merge-path-list
       load-path
       (mapcar #'(lambda (package) (expand-file-name package plugins-directory))
	       package-resource)))
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; End:

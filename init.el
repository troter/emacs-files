;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;;; (@* "TODO")
;;
;; - folding.elの設定を書く
;; - moccurとanything-c-moccurの使い方を調べる
;; - re-builder.elを試す
;; - psvn.el, dsvn.elの調査
;; - icicles.elがどんなものか試す
;; - org-modeを試す
;; - windows, mac, linuxで利用できるsuper key, hyper keyの設定
;;   （右optionや右windowskeyに設定したい）
;;

;; Common Lisp extensions for Emacs.
(require 'cl)

;; Emacs program.
(setq emacs-bin (car command-line-args))


;; (@* "utilities")
;; refer: http://d.hatena.ne.jp/tomoya/20090807/1249601308
(defun x->bool (elt) (not (not elt)))

(defun flatten (lis)
  "Removes nestings from a list."
  (cond ((atom lis) lis)
        ((listp (car lis))
         (append (flatten (car lis)) (flatten (cdr lis))))
        (t (append (list (car lis)) (flatten (cdr lis))))))

(defun fold-right (proc init lis)
  (if lis
      (funcall proc (car lis) (fold-right proc init (cdr lis))) init))

(defun fold-left (proc init lis)
  (if lis (fold-left proc (funcall proc init (car lis)) (cdr lis)) init))

(defalias 'fold 'fold-left)

(defun compose (&rest flist)
  `(lambda (&rest args)
     (dolist (f
              '(,@(reverse flist))
              (car args))
       (setq args
             (list (apply f args))))))

;; (@* "predicates")
;; emacs-version predicates
(dolist (ver '("22" "23" "23.0" "23.1" "23.2"))
  (set (intern (concat "emacs" ver "-p"))
       (if (string-match (concat "^" ver) emacs-version)
           t nil)))

;; system-type predicates
(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      carbon-p  (eq window-system 'mac)
      bsd-p     (eq system-type 'berkeley-unix)
      linux-p   (eq system-type 'gnu/linux)
      colinux-p (when linux-p
                  (let ((file "/proc/modules"))
                    (and
                     (file-readable-p file)
                     (x->bool
                      (with-temp-buffer
                        (insert-file-contents file)
                        (goto-char (point-min))
                        (re-search-forward "^cofuse\.+" nil t))))))
      cygwin-p  (eq system-type 'cygwin)
      nt-p      (eq system-type 'windows-nt)
      meadow-p  (featurep 'meadow)
      windows-p (or cygwin-p nt-p meadow-p))

;; (@* "various path")
;; - (@file :file-name libraries-directory)
;; - (@file :file-name initialize-directory)
;; - (@file :file-name plugins-directory)
;; - (@file :file-name info-directory)
(setq base-directory "~/.emacs.d"
      libraries-directory (expand-file-name "library" base-directory)
      initialize-directory (expand-file-name "initialize" base-directory)
      plugins-directory (expand-file-name "plugins" base-directory)
      info-directory (expand-file-name "info" base-directory))

(defun load-path-recompile (dir)
  (let (save-abbrevs) (byte-recompile-directory dir)))

(defun merge-path-list (init lis)
  (fold-right (lambda (x y)
          (let ((expanded-name (expand-file-name x)))
            (if (file-accessible-directory-p x)
                (append (list expanded-name)
                        (delete x (delete expanded-name y)))
              y)))
        init lis))

(setq load-path
      (merge-path-list
       load-path
       (list plugins-directory
             libraries-directory)))
(load-path-recompile plugins-directory)
(load-path-recompile libraries-directory)

(setq exec-path
      (merge-path-list
       exec-path
       (list "~/bin"
             "~/local/bin"
             "/bin"
             "/opt/local/bin"
             "/opt/local/sbin"
             "/usr/local/bin"
             "/usr/local/sbin"
             "/sbin"
             "/usr/bin"
             "/usr/sbin"
             "/usr/X11R6/bin"
             (concat (getenv "SystemDrive") "/cygwin/usr/bin")
             (concat (getenv "SystemDrive") "/cygwin/usr/sbin")
             (concat (getenv "SystemDrive") "/cygwin/usr/local/bin")
             (concat (getenv "SystemDrive") "/cygwin/usr/local/sbin"))))

(setq Info-additional-directory-list
      (merge-path-list
       nil
       (list info-directory
             "/Applications/Emacs.app/Contents/Resources/info/"
             "/opt/local/share/info"
             "/usr/local/share/info/"
             "/usr/share/info/"
             (concat (getenv "SystemDrive") "/cygwin/usr/local/share/info/")
             (concat (getenv "SystemDrive") "/cygwin/usr/share/info/"))))

;; (@* "load configuration files.")
(defun load-directory-files (dir &optional regex)
  (let*
      ((regex (or regex ".+"))
       (files (and
               (file-accessible-directory-p dir)
               (directory-files dir 'full regex))))
    (mapc (lambda (file)
            (when (load file nil t)
              (message "`%s' loaded." file))) files)))

;; load direcotry files.
;; - (@file :file-name libraries-directory)
;; - (@file :file-name initialize-directory)
(load-directory-files libraries-directory "^.+el$")
(load-directory-files plugins-directory "^subdirs\\.el$")
(load-directory-files initialize-directory "^\\+?init.+el$")

;;; End of .emacs.el

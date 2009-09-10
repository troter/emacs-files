;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; My emacs.el.
;;; ============

;; Common Lisp extensions for Emacs.
(require 'cl)

;; refer: http://d.hatena.ne.jp/tomoya/20090807/1249601308
(defun x->bool (elt) (not (not elt)))

(defun flatten (lis)
  "Removes nestings from a list."
  (cond ((atom lis) lis)
        ((listp (car lis))
         (append (flatten (car lis)) (flatten (cdr lis))))
        (t (append (list (car lis)) (flatten (cdr lis))))))

;; emacs-version predicates
(dolist (ver '("22" "23" "23.0" "23.1" "23.2"))
  (set (intern (concat "emacs" ver "-p"))
       (if (string-match (concat "^" ver) emacs-version)
           t nil)))

;; system-type predicates
(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      carbon-p  (eq window-system 'mac)
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

;; string utility
(defun strings-join (strings &optional separator)
  (if (and separator strings)
      (let ((rs (list (car strings)))
            (ss (cdr strings)))
        (while ss
          (setq rs (cons (car ss) (cons separator rs)))
          (setq ss (cdr ss)))
        (setq strings (reverse rs))))
  (apply 'concat strings))

(setq base-directory "~/.emacs.d"
      conf-directory (expand-file-name "conf" base-directory)
      plugins-directory (expand-file-name "plugins" base-directory)
      libraries-directory (expand-file-name "library" base-directory))

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
       (list "/Applications/Emacs.app/Contents/Resources/info/"
             "/opt/local/share/info"
             "/usr/local/share/info/"
             "/usr/share/info/"
             (concat (getenv "SystemDrive") "/cygwin/usr/local/share/info/")
             (concat (getenv "SystemDrive") "/cygwin/usr/share/info/"))))

(defun load-directory-files (dir &optional regex)
  (let*
      ((regex (or regex ".+"))
       (files (and
               (file-accessible-directory-p dir)
               (directory-files dir 'full regex))))
    (mapc (lambda (file)
            (when (load file nil t)
              (message "`%s' loaded." file))) files)))


(load-directory-files libraries-directory "^.+el$")
(load-directory-files conf-directory "^init.+el$")



;;; Loading.
;;; ========

;; basis
(load "language-settings")
(load "input-method-settings")
(load "look-and-feel-settings")
(load "misc-settings")
(load "carbon-emacs-settings")
(load "windows-settings")

;; others
(load "buffer-settings.el")
(load "dired-settings.el")
(load "term-settings.el")
(load "mode-settings.el")
;(load "anything-settings.el")

;;; Key binding configuration.
;;; ==========================
;(global-set-key "\C-z" 'undo)                       ;;UNDO
(global-set-key [f1] 'help-for-help)
(global-set-key "\C-h" 'backward-delete-char) ;;Ctrl-Hでバックスペース
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))
(define-key global-map (kbd "C-;") 'anything)

;;; End of .emacs.el

;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;; refer: http://openlab.dino.co.jp/wp-content/uploads/2008/08/dot-emacs.txt
;; flymake (Emacs22から標準添付されている)
(when (require 'flymake nil t)
  ;; PHP用設定
  (when (not (fboundp 'flymake-php-init))
    ;; flymake-php-initが未定義のバージョンだったら、自分で定義する
    (defun flymake-php-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local-file "-l"))))
    (setq flymake-allowed-file-name-masks
          (append
           flymake-allowed-file-name-masks
           '(("\\.php[345]?$" flymake-php-init))))
    (setq flymake-err-line-patterns
          (cons
           '("\\(\\(?:Parse error\\|Fatal error\\|Warning\\): .*\\) in \\(.*\\) on line \\([0-9]+\\)" 2 3 nil 1)
           flymake-err-line-patterns)))
  (eval-after-load "php-mode"
    '(progn (defun-add-hook 'php-mode-hook (flymake-mode t))))

  ;; JavaScript用設定
  (when (not (fboundp 'flymake-javascript-init))
    ;; flymake-javascript-initが未定義のバージョンだったら、自分で定義する
    (defun flymake-javascript-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        ;;(list "js" (list "-s" local-file))
        (list "jsl" (list "-process" local-file))
        ))
    (setq flymake-allowed-file-name-masks
          (append
           flymake-allowed-file-name-masks
           '(("\\.json$" flymake-javascript-init)
             ("\\.js$" flymake-javascript-init))))
    (setq flymake-err-line-patterns
          (cons
           '("\\(.+\\)(\\([0-9]+\\)): \\(?:lint \\)?\\(\\(?:warning\\|SyntaxError\\):.+\\)" 1 2 nil 3)
           flymake-err-line-patterns)))
  (defun-add-hook 'javascript-mode-hook (flymake-mode t))

  (when (not (fboundp 'flymake-ruby-init))
    ;; Invoke ruby with '-c' to get syntax checking
    (defun flymake-ruby-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list "ruby" (list "-c" local-file))))

    (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
    (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

    (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

    (eval-after-load "ruby-mode"
      '(defun-add-hook 'ruby-mode-hook
         ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
         (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
             (flymake-mode)))))

  (when (not (fboundp 'flymake-elisp-init))
    (defun flymake-elisp-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list (concat base-directory "/bin/elisplint") (list "-p" (car command-line-args) local-file))))
    (push '("\\.el$" flymake-elisp-init) flymake-allowed-file-name-masks)
    (defun-add-hook 'emacs-lisp-mode-hook 'flymake-mode))
)

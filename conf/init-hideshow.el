;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;;; (@* "hideshow")
(when (require 'hideshow)
  (setq hs-isearch-open t
        hs-hide-comments-when-hiding-all t
        search-invisivle nil)

  (defvar hs-toggle-hiding-all-flag nil)
  (defvar hs-toggle-hiding-all-level 2)
  (defun hs-toggle-hiding-all ()
    (interactive)
    (if hs-toggle-hiding-all-flag
        (save-excursion
          (goto-char (point-min))
          (hs-hide-level hs-toggle-hiding-all-level)
          (while
              (re-search-forward hs-c-start-regexp (point-max) t)
            (hs-hide-block)
            (next-line)))
      (hs-show-all))
    (setq hs-toggle-hiding-all-flag (not hs-toggle-hiding-all-flag)))

  (define-key hs-minor-mode-map [(control c) (h)] 'hs-hide-block)
  (define-key hs-minor-mode-map [(control c) (s)] 'hs-show-block)
  (define-key hs-minor-mode-map [(control meta i)] 'hs-toggle-hiding)
  (define-key hs-minor-mode-map [(control meta y)] 'hs-toggle-hiding-all)

  (dolist (var '(hs-toggle-hiding-all-flag
                 hs-toggle-hiding-all-level))
    (make-variable-buffer-local var))

  (defvar hs-minor-mode-function 'hs-minor-mode)

  (when window-system
    ;; (@* "hidehowvis")
    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/hideshowvis.el")
    (autoload-if-found 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
    (define-fringe-bitmap 'my-hidesowvis-showable-marker [0 24 24 126 126 24 24 0])

    (defcustom hs-fringe-face 'hs-fringe-face
      "*Specify face used to highlight the fringe on hidden regions."
      :type 'face
      :group 'hideshow)

    (defface hs-fringe-face
      '((t (:foreground "#888" :box (:line-width 2 :color "grey75" :style released-button))))
      "Face used to highlight the fringe on folded regions"
      :group 'hideshow)

    (defcustom hs-face 'font-lock-type-face
      "*Specify the face to to use for the hidden region indicator"
      :type 'face
      :group 'hideshow)
    (setq hs-minor-mode-function 'hideshowvis-enable))

  (defun get-javadoc-comment-headline (start end)
    "Return Javadoc comment headline."
    (save-excursion
      (save-restriction
        (narrow-to-region start end)
        (goto-char (point-min))
        (if (re-search-forward "[ \t]\\*[ \t]?" nil t)
            (let ((beg (point)))
              (end-of-line)
              (buffer-substring beg (point)))
          nil))))

  (defun display-code-line-counts-and-comment-headline (ov)
    (let* ((marker-string "*fringe-dummy*")
           (marker-length (length marker-string))
           (line-count (count-lines (overlay-start ov) (overlay-end ov)))
           (headline (get-javadoc-comment-headline (overlay-start ov) (overlay-end ov)))
           (display-string (format "...<%d>" line-count)))
      (when headline
        (setq display-string (concat (format "...[%s]" headline) display-string)))
      (overlay-put ov 'help-echo "Hiddent text. C-c,= to show")
      (when window-system
        (put-text-property 0 marker-length 'display (list 'left-fringe 'my-hidesowvis-showable-marker 'hs-fringe-face) marker-string)
        (overlay-put ov 'before-string marker-string))
      (put-text-property 0 (length display-string) 'face 'hs-face display-string)
      (overlay-put ov 'display display-string)))

  (setq hs-set-up-overlay 'display-code-line-counts-and-comment-headline)

  (dolist (hook (list 'emacs-lisp-mode-hook
                      'c++-mode-hook))
    (defun-add-hook hook (funcall hs-minor-mode-function)))
  (defun-eval-after-load 'php-mode
    (defun-add-hook 'php-mode-hook
      (funcall hs-minor-mode-function))))

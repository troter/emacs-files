;;; -*- coding: utf-8; indent-tabs-mode: nil -*-

;;; (@* "hideshow")
(when (require 'hideshow)
  (setq hs-isearch-open t
        hs-hide-comments-when-hiding-all t
        search-invisivle nil)

  (add-to-list
   'hs-special-modes-alist
   '(php-mode "{" "}" "/[*/]" nil hs-c-like-adjust-block-beginning))

  (defvar tr:hs-minor-mode 'hs-minor-mode
    "Hideshow minor mode function.")

  (when window-system
    ;; (@* "hidehowvis")
    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/hideshowvis.el")
    (autoload-if-found 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
    (autoload-if-found 'hideshowvis-minor-mode "hideshowvis" "Highlight foldable regions")
    (setq tr:hs-minor-mode 'hideshowvis-minor-mode)
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
      :group 'hideshow))

  ;; my-hiding-all
  (defvar tr:hs-toggle-hiding-all-flag nil
    "Toggle flag for `tr:hs-toggle-hiding-all'.")
  (defvar tr:hs-toggle-hiding-all-level 2
    "hide level for `tr:hs-toggle-hiding-all'.")
  (defun tr:hs-toggle-hiding-all ()
    "Toggle hiding/showing of all block."
    (interactive)
    (if tr:hs-toggle-hiding-all-flag
        (hs-show-all)
      (save-excursion
        (goto-char (point-min))
        (hs-hide-level tr:hs-toggle-hiding-all-level)
        (while
            (re-search-forward hs-c-start-regexp (point-max) t)
          (unless (hs-already-hidden-p) (hs-hide-block))
          (next-line))))
    (setq tr:hs-toggle-hiding-all-flag (not tr:hs-toggle-hiding-all-flag)))
  (defun-add-hook 'hs-minor-mode-hook
    (dolist (var '(tr:hs-toggle-hiding-all-flag
                   tr:hs-toggle-hiding-all-level))
      (make-variable-buffer-local var)))

  (defun tr:hs-show-block-children ()
    "Select a block and only show 1st level children."
    (interactive)
    (hs-show-block)
    (hs-hide-level 1))

  (define-key hs-minor-mode-map [(control c) (h)] 'hs-hide-block)
  (define-key hs-minor-mode-map [(control c) (s)] 'hs-show-block)
  (define-key hs-minor-mode-map [(control c) (i)] 'tr:hs-show-block-children)
  (define-key hs-minor-mode-map [(control meta i)] 'hs-toggle-hiding)
  (define-key hs-minor-mode-map [(control meta y)] 'tr:hs-toggle-hiding-all)

  ;; hs-set-up-overlay
  (defun tr:get-javadoc-comment-headline (start end)
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

  (defun tr:display-code-line-counts-and-comment-headline (ov)
    (let* ((marker-string "*fringe-dummy*")
           (marker-length (length marker-string))
           (line-count (count-lines (overlay-start ov) (overlay-end ov)))
           (headline (tr:get-javadoc-comment-headline (overlay-start ov) (overlay-end ov)))
           (display-string (format "...<%d>" line-count)))
      (when headline
        (setq display-string (concat (format "...[%s]" headline) display-string)))
      (overlay-put ov 'help-echo "Hiddent text. C-c,= to show")
      (when window-system
        (put-text-property 0 marker-length 'display (list 'left-fringe 'my-hidesowvis-showable-marker 'hs-fringe-face) marker-string)
        (overlay-put ov 'before-string marker-string))
      (put-text-property 0 (length display-string) 'face 'hs-face display-string)
      (overlay-put ov 'display display-string)))

  (setq hs-set-up-overlay 'tr:display-code-line-counts-and-comment-headline)

  (dolist (hook (list 'emacs-lisp-mode-hook
                      'c++-mode-hook
                      'php-mode-hook))
    (defun-add-hook hook (funcall tr:hs-minor-mode 1)))
)

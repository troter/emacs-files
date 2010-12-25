;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;; 
(when (require 'auto-complete-config nil t)

  (setq ac-menu-height 20)
  (setq ac-candidate-limit 10)
  (setq ac-dwin t)

  ;; default sources
  (set-default 'ac-sources '(ac-source-abbrev ac-source-words-in-buffer))
  (when (ac-yasnippet-initialize)
    (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer)))

  (defun-add-hook 'emacs-lisp-mode-hook (ac-emacs-lisp-features-initialize))
  (defun-add-hook 'auto-complete-mode-hook (add-to-list 'ac-sources 'ac-source-filename))

  (defun-eval-after-load 'anything
    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/ac-anything.el")
    (require 'ac-anything)
    (define-key ac-complete-mode-map [(meta i)] 'ac-complete-with-anything))

  ;; auto-complete.el の ac-source-words-in-buffer の候補に日本語を含む単語が含まれないようにする
  ;; refer: http://d.hatena.ne.jp/IMAKADO/20090813/1250130343
  (defadvice ac-candidate-words-in-buffer (after remove-word-contain-japanese activate)
    (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
      (setq ad-return-value
            (remove-if contain-japanese ad-return-value))))

  ;;; keybindings
  (global-auto-complete-mode t)
  (ac-set-trigger-key "TAB")

  ;; Don't start completion automatically
  (setq ac-auto-start nil)
  (global-set-key "\M-/" 'auto-complete)

  ;; Use C-n/C-p to select candidates
  (define-key ac-complete-mode-map [(control n)] 'ac-next)
  (define-key ac-complete-mode-map [(control p)] 'ac-previous)

  ;; Select candidates by TAB
  (define-key ac-complete-mode-map [(tab)] 'ac-expand)
  ;; Completion by RETURN
  (define-key ac-complete-mode-map [(return)] 'ac-complete)
)

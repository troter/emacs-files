;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;; 
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories (expand-file-name "auto-complete/ac-dict" plugins-directory))

  (setq ac-menu-height 20)
  (setq ac-ignore-case 'smart)
  (setq ac-dwin t)
;;
;;  ;; default sources
;;  ;;(set-default 'ac-sources '(ac-source-abbrev ac-source-words-in-buffer))
;;  ;;(when (ac-yasnippet-initialize)
;;  ;;  (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer)))
;;
;;  (defun-eval-after-load 'anything
;;    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/ac-anything.el")
;;    (require 'ac-anything)
;;    (define-key ac-mode-map [(meta i)] 'ac-complete-with-anything))

  ;;; keybindings
  (ac-set-trigger-key "TAB")

  ;; ;; Don't start completion automatically
  ;; (setq ac-auto-start nil)
  (global-set-key "\M-/" 'auto-complete)

  ;; Use C-n/C-p to select candidates
  (setq ac-use-menu-map t)
  (define-key ac-menu-map [(control n)] 'ac-next)
  (define-key ac-menu-map [(control p)] 'ac-previous)
  ;;(define-key ac-complete-mode-map [(control n)] 'ac-next)
  ;;(define-key ac-complete-mode-map [(control p)] 'ac-previous)

  ;; Help
  (define-key ac-mode-map (kbd "C-c h") 'ac-last-quick-help)
  (define-key ac-mode-map (kbd "C-c H") 'ac-last-help)

  ;; Stop completion
  (define-key ac-completing-map "\M-/" 'ac-stop)
;;
;;  ;; Select candidates by TAB
;;  (define-key ac-complete-mode-map [(tab)] 'ac-expand)
;;  ;; Completion by RETURN
;;  (define-key ac-complete-mode-map [(return)] 'ac-complete)

  ;; Enable auto-complete
  (ac-config-default)
)

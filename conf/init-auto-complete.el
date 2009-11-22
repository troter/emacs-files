;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;; (auto-install-batch "auto-complete development version")
(when (require 'auto-complete nil t)
  (require 'auto-complete-yasnippet)
  (global-auto-complete-mode t)

  (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))

  ;; auto-complete.el の ac-source-words-in-buffer の候補に日本語を含む単語が含まれないようにする
  ;; refer: http://d.hatena.ne.jp/IMAKADO/20090813/1250130343
  (defadvice ac-candidate-words-in-buffer (after remove-word-contain-japanese activate)
    (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
      (setq ad-return-value
            (remove-if contain-japanese ad-return-value))))


  ;; Use M-n/M-p to select candidates
  (define-key ac-complete-mode-map [(meta n)] 'ac-next)
  (define-key ac-complete-mode-map [(meta p)] 'ac-previous)

  ;; Completion by TAB
  (define-key ac-complete-mode-map [(tab)] 'ac-complete)
  (define-key ac-complete-mode-map [(return)] nil)

  (defun-eval-after-load 'anything
    ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/ac-anything.el")
    (require 'ac-anything)
    (define-key ac-complete-mode-map [(meta i)] 'ac-complete-with-anything))
)

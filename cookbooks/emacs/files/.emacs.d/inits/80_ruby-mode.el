;; end に対応する行の highlight
(use-package ruby-mode
  :ensure t)

;; (autoload 'ruby-block-mode "ruby-block" nil t)
;; (setq ruby-block-highlight-toggle t)

;; (defun ruby-mode-hooks ()
;;   (ruby-block-mode t)
;;   (setq ruby-block-highlight-toggle t))

(defun toggle-ruby-magic-comment ()
  "toggle magic comment top of line"
  (interactive)
  (if (null ruby-insert-encoding-magic-comment)
      (setq ruby-insert-encoding-magic-comment t)
    (setq ruby-insert-encoding-magic-comment nil)))

(setq ruby-deep-indent-paren-style nil)

(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; デフォルトではマジックコメントを挿入しない
(setq ruby-insert-encoding-magic-comment nil)

;; (add-hook 'ruby-mode-hook 'ruby-mode-hooks 'ruby-indent-line)
(autoload 'ruby-mode "ruby-mode" nil t)
(add-to-list 'auto-mode-alist
             '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\.cap$" . ruby-mode))

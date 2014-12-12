;; end に対応する行の highlight
(require 'ruby-block)
(setq ruby-block-highlight-toggle t)

(defun ruby-mode-hooks ()
  (ruby-block-mode t))

(defun toggle-ruby-magic-comment ()
  "toggle magic comment top of line"
  (interactive)
  (if (null ruby-insert-encoding-magic-comment)
      (setq ruby-insert-encoding-magic-comment t)
    (setq ruby-insert-encoding-magic-comment nil)))

;; デフォルトではマジックコメントを挿入しない
(toggle-ruby-magic-comment)

(add-hook 'ruby-mode-hook 'ruby-mode-hooks)
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

;; end に対応する行の highlight
(require 'ruby-block)
(setq ruby-block-highlight-toggle t)

;; inf-ruby
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

(defun ruby-mode-hooks ()
  (inf-ruby-keys)
;  (ruby-electric-mode t)
  (ruby-block-mode t)
  (define-key ruby-mode-map (kbd "C-c r") 'execute-rspec))
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

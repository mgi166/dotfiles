(require 'yasnippet)
(setq yas-snippet-dirs nil)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x y v") 'yas-visit-snippet-file)

(define-key yas-minor-mode-map (kbd "M-i") 'yas/expand)

(defun toggle-yas-mode ()
  (interactive)
  (yas-global-mode 'toggle)
  (message "Toggle yas-mode"))

;; yas-mode を toggle する
(global-set-key (kbd "C-x y m") 'toggle-yas-mode)



(tab-bar-mode 1)
(defvar ctl-z-map (make-keymap))
(define-key global-map (kbd "C-z") ctl-z-map)
(tab-bar-history-mode 1)

(require 'cl-lib)

(defun my/remove-first-if (func list)
  "Remove the first element from list that satisfies func."
  (let (found)
    (cl-loop for x in list
             unless (and (not found) (funcall func x))
             collect x
             do (when (funcall func x) (setq found t)))))

(defun my/exist-p-tab-bar-except-self (name)
  "Whether target tab exists in current tabs except self."
  (let* ((tab-bar-tabs-without-self (my/remove-first-if (lambda (tab) (equal (alist-get 'name tab) name)) (funcall tab-bar-tabs-function))))
    (cl-some (lambda (tab) (equal (alist-get 'name tab) name))
             tab-bar-tabs-without-self)))

(defun my/tab-close ()
  "tab close + kill buffer if current tab is duplicated otherwise tab close only"
  (interactive)
  (if (my/exist-p-tab-bar-except-self (alist-get 'name (tab-bar--current-tab-make)))
      (tab-close)
    (progn (kill-this-buffer) (tab-close))))

(define-key ctl-z-map (kbd "k") 'my/tab-close)
(define-key ctl-z-map (kbd "u") 'tab-undo)
(define-key ctl-z-map (kbd "d") 'dired-other-tab)
(define-key ctl-z-map (kbd "C-s") 'tab-move)
(define-key ctl-z-map (kbd "C-k") 'tab-close)
(define-key ctl-z-map (kbd "C-c") 'tab-new)
(define-key ctl-z-map (kbd "C-d") 'dired-other-tab)
(define-key ctl-z-map (kbd "C-n") 'tab-next)
(define-key ctl-z-map (kbd "C-p") 'tab-previous)

(define-key global-map (kbd "M-]") 'tab-next)
(define-key global-map (kbd "M-[") 'tab-previous)
(define-key global-map (kbd "s-}") 'tab-next)
(define-key global-map (kbd "s-{") 'tab-previous)

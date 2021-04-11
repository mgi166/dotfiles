;; [0, 1, 2] で 1 をkill-screen したときに [0, 1] となるようにする
;; see(http://d.hatena.ne.jp/asudofu/20091121/1258778536)
(defun elscreen-insert-internal (screen)
  (elscreen-clone screen)
  (elscreen-kill-internal screen))

(defun elscreen-get-gap-next ()
  (let ((screen-list (sort (elscreen-get-screen-list) '<))
        (screen 0))
    (while (eq (nth screen screen-list) screen)
      (setq screen (+ screen 1)))
    (nth screen screen-list)))

(defun elscreen-get-packed-num ()
  (let ((screen-list (sort (elscreen-get-screen-list) '<))
        (current-screen (elscreen-get-current-screen))
        (screen 0))
    (while (not (eq (nth screen screen-list) current-screen))
      (setq screen (+ screen 1)))
    screen))

(defun elscreen-pack-list ()
  (interactive)
  (let ((next (elscreen-get-gap-next))
        (pack (elscreen-get-packed-num)))
    (while next
      (elscreen-insert-internal next)
      (setq next (elscreen-get-gap-next)))
    (elscreen-goto pack)
    (elscreen-notify-screen-modification 'force)))

;; elscreen.el 非依存版 (バッファをタブ化。http://d.hatena.ne.jp/tam5917/20120922/1348286748)
(use-package elscreen
  :ensure t
  :init (setq elscreen-tab-display-kill-screen nil) ;; [X]を表示しない
        (setq elscreen-tab-display-control nil)     ;; [<->]を表示しない
        (add-hook 'elscreen-kill-hook 'elscreen-pack-list) ;; killしたらpackする
  ;; C-z k or C-z C-k でバッファもkillするように
  ;; C-z K or C-z C-K で screen のみ kill する
  :bind (:map elscreen-map ("C-k" . elscreen-kill-screen-and-buffers)
                           ("k" . elscreen-kill-screen-and-buffers)
                           ("K" . elscreen-kill-screen-and-buffers)
                           ("C-K" . elscreen-kill)
                           ("C-o" . elscreen-kill-others))
        ("M-[" . elscreen-previous)
        ("M-]" . elscreen-next)
        ("s-{" . elscreen-previous)
        ("s-}" . elscreen-next)
        ("“" . elscreen-previous)
        ("”" . 'elscreen-next)
  :init (elscreen-start))

(if window-system
  (define-key elscreen-map "\C-z" 'iconify-or-deiconify-frame)
  (define-key elscreen-map "\C-z" 'suspend-emacs))

;; elscreen-server
(use-package elscreen-server)

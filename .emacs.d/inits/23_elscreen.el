;; elscreen.el 非依存版 (バッファをタブ化。http://d.hatena.ne.jp/tam5917/20120922/1348286748)
(require 'elscreen)
(elscreen-start)
(if window-system
  (define-key elscreen-map "\C-z" 'iconify-or-deiconify-frame)
  (define-key elscreen-map "\C-z" 'suspend-emacs))

;; elscreen 用 keybind
;;(define-key mac-key-mode-map [(alt t)] 'elscreen-create) ;; 新しいタブを開く(elscreen + mac-key-mode 必須)
(define-key global-map "\M-[" 'elscreen-previous)
(define-key global-map "\M-]" 'elscreen-next)

;; C-z k or C-z C-k でバッファもkillするように
(define-key elscreen-map "\C-k" 'elscreen-kill-screen-and-buffers)
(define-key elscreen-map "k" 'elscreen-kill-screen-and-buffers)

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

;killしたらpackする
(add-hook 'elscreen-kill-hook 'elscreen-pack-list)

;; elscreen-server
(require 'elscreen-server)

;;ツールバーを隠す
(tool-bar-mode 0)

;;メニューバーを消す
(menu-bar-mode nil)

;;スタートアップを表示しない
(setq inhibit-startup-message t)

;;スタートアップスクリーンを消す
(setq setq-startup-screen -1)

;;最初のメッセージを消す
(setq initial-scratch-message "")

;;バックアップファイルを作らない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; "For information about GNU Emacs and the GNU system, type C-h C-a." とミニバッファに表示しない。
(defun display-startup-echo-area-message ()
  "If it wasn't for this you'd be GNU/Spammed by now"
  (message ""))

;; vc-git..done という表示をなくす
(setq vc-handled-backends nil)

;; ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; "ls does not support --dired see `dired-use-ls-dired' for more details." とミニバッファに表示しない
(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil)
(setq dired-use-ls-dired nil)

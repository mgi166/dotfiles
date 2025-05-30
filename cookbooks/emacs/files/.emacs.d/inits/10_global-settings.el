;;対応する括弧を光らせる
(show-paren-mode t)

;;括弧強調表示までの時間
(setq show-paren-delay 0)

;;選択部分のハイライト
(transient-mark-mode t)

;;カーソルの位置が何文字目か表示
(column-number-mode t)

;;カーソルの位置が何行目か表示
(line-number-mode t)

;;画像ファイルを表示
(auto-image-file-mode t)

;;最終行に必ず一行挿入する
(setq require-final-newline t)

;;現在開いているファイルのフルパスを確認
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;;スクロールバーを右側に表示する
(unless (not window-system)
  (set-scroll-bar-mode 'right)
)

;;ファイルサイズを表示
(size-indication-mode t)

;; スペースとタブだけの行を強調表示
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;; Tabの代わりにスペースでインデント
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;;"yes or no" を "y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;;スクロールを１行づつ
(setq scroll-step 1)

;; 1行づつスクロールする
(setq scroll-conservatively 1)

;; C-k で改行を含めてカット
(setq kill-whole-line t)

;;ファイルが#!で始まる場合、+xを付けて保存する
(add-hook 'after-save-hock
          'executable-make-buffer-file-executable-if-script-p)

;; 自動保存 file と backup file 作成を無効
(setq make-backup-files nil)
(setq auto-save-default nil)

;; OS のクリップボードと emacs の kill-ring 連携する
(setq x-select-enable-clipboard t)

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; zshを使う
(cond ((file-exists-p (concat (getenv "HOMEBREW_PREFIX") "/bin/zsh")) (setq shell-file-name (concat (getenv "HOMEBREW_PREFIX") "/bin/zsh")))
      ((file-exists-p "/bin/zsh") (setq shell-file-name "/bin/zsh")))

;; find-file をした時の default の directory を設定
(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; find-fileのファイル名補完で大文字小文字を区別しない設定
(setq completion-ignore-case t)

;; C-Ret で矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; キャレット(カーソル)のタイプと表示
(setq cursor-type 'box)
(blink-cursor-mode 0)

;; ¥(yen) を \(backslash) に
(define-key global-map [165] [92])

;; 非nil値に変更した場合、*compilation* buffer の出力に追随して自動的にスクロールする
(setq compilation-scroll-output t)

;; 左側に行数表示
(global-display-line-numbers-mode 1)

;; custom variable の保存先を変更
(setq custom-file (locate-user-emacs-file "~/.emacs.d/custom.el"))
(when (file-exists-p (expand-file-name custom-file))
  (load-file (expand-file-name custom-file)))

;; 以前に開いていた位置を保存/復元する
(save-place-mode 1)

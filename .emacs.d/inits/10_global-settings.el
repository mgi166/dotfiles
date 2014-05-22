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

;;行数表示
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

;; zshを使う
(setq shell-file-name "/usr/local/bin/zsh")

;; find-file をした時の default の directory を設定
(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; find-fileのファイル名補完で大文字小文字を区別しない設定
(setq completion-ignore-case t)

;; C-Ret で矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; ミニバッファの履歴を "C-p" と "C-n" で辿れるようにする
(define-key minibuffer-local-must-match-map "\C-p" 'previous-history-element)
(define-key minibuffer-local-must-match-map "\C-n" 'next-history-element)
(define-key minibuffer-local-completion-map "\C-p" 'previous-history-element)
(define-key minibuffer-local-completion-map "\C-n" 'next-history-element)
(define-key minibuffer-local-map "\C-p" 'previous-history-element)
(define-key minibuffer-local-map "\C-n" 'next-history-element)

;;行をハイライト
(defface my-hl-line-face
  '((((class color) (background dark))
     (:background "Gray25" t))
    (((class color) (background light))
     (:background "LightGoldenrodYellow" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;; キャレット(カーソル)のタイプと表示
(setq blink-cursor-interval 0.5)
(setq blink-cursor-delay 30.0)
(blink-cursor-mode 1)

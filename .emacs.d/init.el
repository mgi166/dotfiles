;##### 日本語の設定

;;日本語の設定
(set-language-environment "Japanese")

;;極力utf-8とする
(prefer-coding-system 'utf-8)

;;日本語infoの文字化け防止
(auto-compression-mode t)

;; font の設定
(set-face-attribute 'default nil :family "Inconsolata" :height 150)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (cons "Ricty Discord" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (cons "Ricty Discord" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (cons "Ricty Discord" "iso10646-1"))

;#####

;##### load-path関連

;;load-pathの追加
(add-to-list 'load-path "~/.emacs.d/elisp")

;; emacs のversion が23以下なら、user-emacs-directory変数を定義
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))

;; 引数のdirectoryとその sub directoryをload-pathに追加
(defun add-to-load-path (&rest paths)
   (let (path)
     (dolist (path paths paths)
       (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
         (add-to-list 'load-path default-directory)
         (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
             (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "elisp")

;#####


;##### elisp関連

;; common lisp
(require 'cl)

;; mac-key-mode (CocoaEmacsの時は不要)
(when (< emacs-major-version 24)
  (require 'mac-key-mode)
  (mac-key-mode 1)
  (define-key mac-key-mode-map [(alt {)] 'elscreen-previous)
  (define-key mac-key-mode-map [(alt })] 'elscreen-next)
)

;; auto-complite.el(自動補完機能)
(require 'auto-complete)
(global-auto-complete-mode t)

;; linum.el(左側に行数表示)
(require 'linum)
(global-linum-mode t)
(setq linum-format "%5d ")

;; linum の背景色
(custom-set-faces
 '(linum ((t (:inherit (shadow default) :background "Gray23")))))

;; Color-Theme.el(カラーテーマ。お気に入りは color-theme-charcoal-black )
;;(when window-system
(require 'color-theme)
(color-theme-initialize)
;; Select theme
(color-theme-charcoal-black)

;; solarized
;; (require 'color-theme-solarized)
;; (color-theme-solarized-dark)

;; zenburn
;; (require 'zenburn)
;; (color-theme-zenburn)

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

;; ibus(ibusのデフォルトの設定であるC-SPCで入力モード切り替えをset-markに変更@ubuntu)
(when (eq system-type 'gnu/linux)
  (require 'ibus)
  (add-hook 'after-init-hook 'ibus-mode-on)
  (ibus-define-common-key ?\C-\s nil)
)

;; multi-term(端末emulator)
(require 'multi-term)
(setq multi-term-program shell-file-name)
(setq multi-term-program "/bin/zsh")
(setenv "TERMINFO" "~/.terminfo") ; "4m" と出力されないようにする。必要.terminfo(参考: http://passingloop.tumblr.com/post/11324890598/emacs-terminfo-configuration)
(define-key global-map "\M-!" 'multi-term)

;; google-maps(emacs上で、google-mapを使用。何故か使えない)
(require 'google-maps)

;; color-moccer
(require 'color-moccur)
(setq moccur-split-word t)
(add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
(add-to-list 'dmoccur-exclusion-mask "^#.+#$")

;(when (require 'migemo nil t) ; migemo が使えるときは migemo を使う
;  (setq moccur-use-migemo t))
(define-key global-map "\M-o" 'occur-by-moccur)
(define-key global-map (kbd "C-M-o") 'dmoccur)

;; ctags
(require 'ctags nil t)
(setq tags-revert-without-query t)
(setq ctags-command "ctags -e -R")

;; redo+ (emacs 24 だと使えないので注意)
(when (< emacs-major-version 24)
  (require 'redo+)
  (global-set-key (kbd "C-M-/") 'redo)
  (setq undo-no-redo t) ; 過去のundoがredoされないようにする
  (setq undo-limit 600000)
  (setq undo-strong-limit 900000))

;; anything(総合interface。フル装備は M-x の補完が取られるので使用していない)
;; (require 'anything-startup) ;; フル装備

(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)
(and (equal current-language-environment "Japanese")
     (require 'anything-migemo nil t))
(require 'anything-grep nil t) ;;; `anything-grep' replaces standard `grep' command.
(require 'anything-show-completion)

;; anything-for-tags(gtags, ctags, imenu など変数一覧表示)
;; (when (and (require 'anything-exuberant-ctags nil t)
;;            (require 'anything-gtags nil t))
;;   (setq anything-for-tags
;;         (list anything-c-source-imenu
;;               anything-c-source-gtags-select
;;               anything-c-source-exuberant-ctags-select))

;; (defun anything-for-tags ()
;;   "Preconfigured `anything' for anything-for-tags."
;;   (interactive)
;;   (anything anything-for-tags
;;             (thing-at-point 'symbol)
;;             nil nil nil "*anything for tags*"))
;; (define-key global-map "M-t" 'anything-for-tags))

;; anything-for-files (串刺し file 検索)
(define-key global-map "\C-xb" 'anything-for-files)
(define-key global-map "\C-x\C-b" 'anything-for-files)

;; anything-for-elscreen (elscreen のタブを pattern で incremental search する)
(defun anything-for-elscreen ()
  "preconfigured `anything' for anything-for-elscreen"
  (interactive)
  (anything anything-c-source-elscreen
    nil nil nil nil "*anything for elscreen*"))
(define-key global-map "\M-l" 'anything-for-elscreen)

;; org-mode(最新版をinstallしようとして失敗。versionは古いが元々入っているらしい)

;;ESS
;(require 'ess-site)

;; auto-install(M-x elisp-install RET URL で elispのインストールが可能に。通常は起動に時間がかかるのでコメントアウト)
;; (require 'auto-install)
;; (setq auto-install-directory "~/.emacs.d/elisp/")
;; (auto-install-update-emacswiki-package-name t)
;; (auto-install-compatibility-setup)

;; dired
(define-key global-map "\C-x\C-d" 'dired)

;; recentf-ext (バッファも recentf の対象とする)
(require 'recentf-ext)

;; ido mode(ちょっとうるさいので停止)
;; (require 'ido)
;; (ido-mode t)

;; revive.el (前回のバッファをsaveし、load する)
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(define-key ctl-x-map "F" 'resume)                        ; C-x F で復元
(define-key ctl-x-map "K" 'wipe)                          ; C-x K で Kill
(add-hook 'kill-emacs-hook 'save-current-configuration)

;; insert-pair (範囲で囲った部分を、シングルクォート ダブルクオート、大括弧で囲う)
(define-key global-map (kbd "M-\'") 'insert-pair)
(define-key global-map (kbd "M-\"") 'insert-pair)
;; (define-key global-map (kbd "M-[") 'insert-pair)


;; jaspace (全角空白、タブを強調表示 (改行だけ強調しない。emacs 23 以下の version でのみ有効))
(when (< emacs-major-version 23)
  (require 'jaspace)
  (setq jaspace-alternate-jaspace-string "□") ;; 全角空白
  (setq jaspace-alternate-eol-string nil) ;; 改行
  (setq jaspace-highlight-tabs t ) ;; tab
  )

;; WhiteSpace(全角空白、タブを強調表示。(emacs 23 以上の version でのみ有効))
(when (> emacs-major-version 22)
  (require 'whitespace)
  (setq whitespace-style '(face           ; faceで可視化
                           tabs           ; タブ
                           spaces         ; スペース
                           space-mark     ; 表示のマッピング
                           tab-mark
                           ))

   ;; スペースは全角のみを可視化
   (setq whitespace-space-regexp "\\(\u3000+\\)")

   ;; タブやスペースに対して表示される記号
   (setq whitespace-display-mappings
         '((space-mark ?\u3000 [?\u25a1])
           (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

   ;; tab の色
   (set-face-attribute 'whitespace-tab nil
                       :foreground "LightSkyBlue"
                       :underline t)

   ;; 全角スペースの色
   (set-face-attribute 'whitespace-space nil
                       :foreground "GreenYellow"
                       :weight 'bold)
   (global-whitespace-mode t)
   )

;; migemo (ローマ字検索で日本語が引っかかるようにする。事前に cmigemo の install が必要)
(require 'migemo)
(setq migemo-command "/usr/local/bin/cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)
(set-process-query-on-exit-flag migemo-process nil) ;; この設定がないと、Active processes exist; kill them and exit anyway?"などと云われて，"y"を押さないと終了しない

;; wdired (dired 中に r を押すと、file を rename してくれる)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; tramp (リモートサーバーのファイルをローカルにあるように編集できる。パスワードを聞かれないで ssh できることが前提)
;; 使い方 C-x C-f /ssh:user@example.com:/path/to/file
(require 'tramp)

;; undo-tree()
;(require 'undo-tree)
;(global-undo-tree-mode t)
;(global-set-key (kbd "M-/") 'undo-tree-redo)

;; point-undo (ポイントの位置を undo する)
(require 'point-undo)
(define-key global-map [f5] 'point-undo)
(define-key global-map [f6] 'point-redo)

;#####


;##### mode 各種

;; perl-mode

;; perl-mode を cper-mode とする
(defalias 'perl-mode 'cperl-mode)

;; perl-completion
(defun perl-completion-hook ()
  (when (require 'perl-completion nil t)
    (perl-completion-mode t)
    (when (require 'auto-complete nil t)
      (auto-complete-mode t)
      (make-variable-buffer-local 'ac-sources)
      (setq ac-sources
            '(ac-sources-perl-completion)))))
(add-hook 'cper-mode-hook 'perl-completion-hook)

;; ruby-mode

;; 括弧の自動補完。あまりにうるさいので消している。
;(require 'ruby-electric)

;; end に対応する行の highlight
(require 'ruby-block)
(setq ruby-block-highlight-toggle t)

;; inf-ruby
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

(defun execute-rspec ()
  (interactive)
  (do-applescript (format "tell application \"iTerm\"
  activate
  tell current session of current terminal
    write text \"rspec %s\"
  end tell
  end tell
  tell application \"System Events\"
    keystroke return
  end tell"
  buffer-file-name (line-number-at-pos))))

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

;; js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist
             '("\\.js$" . js2-mode))

;#####


;##### keybind関連

;; メタキーをoptionに @mac
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta))

;; keybind
(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(define-key global-map "\M-?" 'help-command) ; help
(define-key global-map "\C-t" 'other-window) ; 他のwindowに切り替える
(define-key global-map "\M-p" 'backward-paragraph)
(define-key global-map "\M-n" 'forward-paragraph)
(define-key global-map [(super z)] 'undo)                 ; undo ;@ubuntu
(define-key global-map [(super c)] 'copy-region-as-kill)  ; copy ;@ubuntu
(define-key global-map [(super v)] 'yank)                 ; yank ;@ubuntu
(define-key global-map [(super x)] 'kill-region)          ; 切り取り ;@ubuntu
(define-key global-map "\C-x\C-k" 'kill-buffer)           ; buffer close
(define-key global-map "\C-\M-^" 'indent-region) ;; indent-region

;; C-k で改行を含めてカット
(setq kill-whole-line t)


;; shiht+矢印キーで領域選択 CarbonEmacs 限定
;; (setq pc-select-selection-key-only t)
;; (pc-selection-mode 1)

;; マウスのホイールスクロールスピードを調節
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 3))
;; (global-set-key [mouse-4] 'scroll-down-with-lines)
;; (global-set-key [mouse-5] 'scroll-up-with-lines)
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)

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

;;; リージョンの大文字小文字変換を有効にする。
;; C-x C-u -> upcase
;; C-x C-l -> downcase
;; (put 'upcase-region 'disabled nil)
;; (put 'downcase-region 'disabled nil)

;#####


;##### color

;;透明度の設定
(add-to-list 'default-frame-alist '(alpha . 80))

;#####


;##### 強調、表示

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

;; スペースとタブだけの行を強調表示
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;; キャレット(カーソル)のタイプと表示
(setq cursor-type 'hollow)
;(set-cursor-color 'indianred) ; 何故か使えない
(setq blink-cursor-interval 0.5)
(setq blink-cursor-delay 30.0)
(blink-cursor-mode 1)

;#####


;##### 不要な表示を消す

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

;; Control + すべてのキーを無視する @mac (mac-add-ignore-shortcut はCarbonEmacs限定。CocoaEmacsでは不要なのでコメントアウトしていい。
(unless (not window-system)
  (when (eq system-type 'darwin)
;;(mac-add-ignore-shortcut '(control)))
))

;; vc-git..done という表示をなくす
(setq vc-handled-backends nil)

;; ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Tabの代わりにスペースでインデント
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)


;#####


;##### その他

;;"yes or no" を "y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; 初期フレームの設定
(require 'my-frame)

;; top    : フレームの Y 位置(ピクセル数)
;; left   : フレームの X 位置(ピクセル数)
;; width  : フレーム幅(文字数)
;; height : フレーム高(文字数)@mac
(setq initial-frame-alist
      (append (set-my-frame-size "~/.emacs.d/frame/private_mac.json")
              initial-frame-alist))

;; 新規フレームのデフォルト設定
(setq default-frame-alist
      (append (set-my-frame-size "~/.emacs.d/frame/private_mac.json")
              default-frame-alist))

;;スクロールを１行づつ
(setq scroll-step 1)

;; 1行づつスクロールする
(setq scroll-conservatively 1)

;;最近使ったファイルをメニューに表示
(recentf-mode 1)
(setq recentf-max-menu-items 200)
(setq recentf-max-saved-items 200)
(global-set-key "\C-xf" 'recentf-open-files)

;;補完機能
(setq partial-complication-mode 1)

;; find-fileのファイル名補完で大文字小文字を区別しない設定
(setq completion-ignore-case t)

;;ファイル更新日を自動的に書き換える
(require 'time-stamp)
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "last updated : ")
(setq time-stamp-format "%04y/%02m/%02d")
(setq time-stamp-end "\\|$")

;;iswitchb モード on
(iswitchb-mode 1) ;;iswitchbモードON
;;; C-f, C-b, C-n, C-p で候補を切り替えることができるように。
(add-hook 'iswitchb-define-mode-map-hook
      (lambda ()
        (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
        (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;;ファイルが#!で始まる場合、+xを付けて保存する
(add-hook 'after-save-hock
          'executable-make-buffer-file-executable-if-script-p)

;;オートセーブファイルを「~/.emacs.d/auto-save-list/」に保存
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/auto-save-list") t)))

;; OS のクリップボードと emacs の kill-ring 連携する
(setq x-select-enable-clipboard t)

;; emacs でコピーした内容とクリップボードを同期
;; (setq darwin-p (eq system-type 'darwin)
;;       linux-p  (eq system-type 'gnu/linux)
;;       carbon-p (eq system-type 'mac)
;;       meadow-p (featurep 'meadow))

;; (defun copy-from-osx ()
;;   (shell-command-to-string "pbpaste"))

;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;; (if (or darwin-p carbon-p)
;;   (setq interprogram-cut-function 'paste-to-osx)
;;   (setq interprogram-paste-function 'copy-from-osx))

;;; Mac Clipboard との共有
;; (defvar prev-yanked-text nil "*previous yanked text")

;; (setq interprogram-cut-function
;;       (lambda (text &optional push)
;;                                         ; use pipe
;;         (let ((process-connection-type nil))
;;           (let ((proc (start-process "pbcopy" nil "pbcopy")))
;;             (process-send-string proc string)
;;             (process-send-eof proc)
;;             ))))

;; (setq interprogram-paste-function
;;       (lambda ()
;;         (let ((text (shell-command-to-string "pbpaste")))
;;           (if (string= prev-yanked-text text) nil (setq prev-yanked-text text)
;;               ))))

;;- See more at: http://yohshiy.blog.fc2.com/blog-entry-129.html#sthash.YmDFR3nk.dpuf
(defun yel-yank ()
  "yank to cycle kill ring"
  (interactive "*")
  (if (or (eq last-command 'yank-pop) (eq last-command 'yank))
      (yank-pop 1) (yank 1))
)
(global-set-key "\C-y" 'yel-yank)

;; zshを使う
(setq shell-file-name "/usr/local/bin/zsh")


;#####

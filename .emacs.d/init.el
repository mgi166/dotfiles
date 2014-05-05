;; load-path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")


;##### load-path関連

;;load-pathの追加
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

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

;; recentf.el
;; 最近使ったファイルをメニューに表示
(recentf-mode 1)
(setq recentf-max-menu-items 200)
(setq recentf-max-saved-items 200)
(global-set-key "\C-xf" 'recentf-open-files)


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

;; emacsclient
(require 'server)
(unless (server-running-p)
  (server-start))

;; C-x C-c で休止
(global-set-key (kbd "C-x C-c") 'ns-do-hide-emacs)

;; M-x exit で emacs 終了
(defalias 'exit 'save-buffers-kill-emacs)

;; elscreen-server
(require 'elscreen-server)


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

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;#####


;##### keybind関連

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


;##### 不要な表示を消す

;; Control + すべてのキーを無視する @mac (mac-add-ignore-shortcut はCarbonEmacs限定。CocoaEmacsでは不要なのでコメントアウトしていい。
(unless (not window-system)
  (when (eq system-type 'darwin)
;;(mac-add-ignore-shortcut '(control)))
))

;#####


;##### その他

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
      (append '((cursor-color . "Gray55"))
              default-frame-alist))

;;補完機能
(setq partial-complication-mode 1)

;;- See more at: http://yohshiy.blog.fc2.com/blog-entry-129.html#sthash.YmDFR3nk.dpuf
(defun yel-yank ()
  "yank to cycle kill ring"
  (interactive "*")
  (if (or (eq last-command 'yank-pop) (eq last-command 'yank))
      (yank-pop 1) (yank 1))
)
(global-set-key "\C-y" 'yel-yank)

;#####

(require 'my-functions)

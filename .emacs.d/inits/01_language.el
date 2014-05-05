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

;;日本語の設定
(set-language-environment "Japanese")

;;極力utf-8とする
(prefer-coding-system 'utf-8)

;;日本語infoの文字化け防止
(auto-compression-mode t)

;; font の設定
(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 160)
(set-fontset-font
    nil 'japanese-jisx0208
        (font-spec :family "Ricty"))

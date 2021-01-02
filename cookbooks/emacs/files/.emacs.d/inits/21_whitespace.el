;; WhiteSpace(全角空白、タブを強調表示)
(use-package whitespace
  :ensure t
  :init (setq whitespace-style '(face           ; faceで可視化
                                 tabs           ; タブ
                                 spaces         ; スペース
                                 space-mark     ; 表示のマッピング
                                 tab-mark))

        ;; スペースは全角のみを可視化
        (setq whitespace-space-regexp "\\(\u3000+\\)")
        ;; タブやスペースに対して表示される記号
        (setq whitespace-display-mappings
              '((space-mark ?\u3000 [?\u25a1])
                (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

  :config (global-whitespace-mode t)
          ;; tab の色
          (set-face-attribute 'whitespace-tab nil
                              :background "Grey15"
                              :foreground "LightSkyBlue"
                              :underline t)

          ;; 全角スペースの色
          (set-face-attribute 'whitespace-space nil
                              :background "Grey15"
                              :foreground "GreenYellow"
                              :weight 'bold))

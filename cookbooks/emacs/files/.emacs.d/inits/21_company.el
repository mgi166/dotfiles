(global-company-mode +1)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

;; ignore-case で補完する
(setq completion-ignore-case t)

;; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq company-selection-wrap-around t)

(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous)

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)


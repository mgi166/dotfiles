(use-package company
  :init
  ;; ignore-case で補完する
  (setq completion-ignore-case t)
  ;; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (setq company-selection-wrap-around t)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  ;; C-n, C-pで補完候補を次/前の候補を選択
  :bind (:map company-active-map ("C-n" . company-select-next)
                                 ("C-p" . company-select-previous)
                                 ("M-<" . company-select-first)
                                 ("M->" . company-select-last)
                                 ("C-h" . delete-backward-char)
                                 ;; C-sで絞り込む
                                 ("C-s" . company-filter-candidates)
                                 ("<tab>" . company-complete-common-or-cycle)
                                 ("<backtab>" . company-select-previous))
        ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
        (:map emacs-lisp-mode-map ("C-M-i" . company-complete)))

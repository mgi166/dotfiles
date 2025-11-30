(use-package vterm
  :straight t
  :hook
  (vterm-mode . (lambda ()
                  (setq show-trailing-whitespace nil))
  :bind
  ;; vterm 上で 1 文字消せないので明示的に関数を bind
  (:map vterm-mode-map
              ("C-h" . vterm-send-backspace))
  ;; vterm 上でも tab-bar-mode の keybind prefix を使用したいので、C-z は emacs に送る
  :config
  (customize-set-variable
   'vterm-keymap-exceptions
   (append vterm-keymap-exceptions '("C-z"))))

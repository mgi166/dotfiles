;; 初期フレームの設定
(require 'my-frame)

;; top    : フレームの Y 位置(ピクセル数)
;; left   : フレームの X 位置(ピクセル数)
;; width  : フレーム幅(文字数)
;; height : フレーム高(文字数)@mac
(setq initial-frame-alist
      (append (set-my-frame-size "~/.emacs.d/frame/private_mac.json")
              initial-frame-alist))

;; ;; 新規フレームのデフォルト設定
;; (setq default-frame-alist
;;       (append '((cursor-color . "Gray55"))
;;               default-frame-alist))

;;透明度の設定
(add-to-list 'default-frame-alist '(alpha . 80))

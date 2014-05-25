;; anything(総合interface。フル装備は M-x の補完が取られるので使用していない)
;; (require 'anything-startup) ;; フル装備

(require 'anything)
(require 'anything-config)
(and (equal current-language-environment "Japanese")
     (require 'anything-migemo nil t))

;; anything-for-files (串刺し file 検索)
(define-key global-map "\C-xb" 'anything-filelist+)
(define-key global-map "\C-x\C-b" 'anything-filelist+)

;; anything-for-elscreen (elscreen のタブを pattern で incremental search する)
(defun anything-for-elscreen ()
  "preconfigured `anything' for anything-for-elscreen"
  (interactive)
  (anything anything-c-source-elscreen
    nil nil nil nil "*anything for elscreen*"))
(define-key global-map "\M-l" 'anything-for-elscreen)

(require 'anything-git-files)
(define-key global-map (kbd "C-c C-b") 'anything-git-files)
(define-key global-map (kbd "C-c b") 'anything-git-files)

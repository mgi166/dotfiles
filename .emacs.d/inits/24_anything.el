;; anything(総合interface。フル装備は M-x の補完が取られるので使用していない)
;; (require 'anything-startup) ;; フル装備

(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)
(and (equal current-language-environment "Japanese")
     (require 'anything-migemo nil t))
(require 'anything-grep nil t) ;;; `anything-grep' replaces standard `grep' command.
(require 'anything-show-completion)

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

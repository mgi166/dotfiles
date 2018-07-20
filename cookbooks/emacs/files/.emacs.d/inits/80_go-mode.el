; NOTE: require
; go get code.google.com/p/rog-go/exp/cmd/godef
; go get -u github.com/nsf/gocode
(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)))

; NOTE: $ go get golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

(define-key go-mode-map "M-." 'godef-jump)
(define-key go-mode-map "M-," 'pop-tag-mark)

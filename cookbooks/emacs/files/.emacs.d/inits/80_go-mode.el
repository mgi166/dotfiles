; NOTE: require
; go get -u github.com/nsf/gocode
(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)

; NOTE: $ go get -u github.com/rogpeppe/godef
     (define-key go-mode-map (kbd "M-.") 'godef-jump)
     (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)))

; NOTE: $ go get golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

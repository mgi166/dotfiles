
; NOTE: require
; go get -u github.com/nsf/gocode
(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)
     (ac-config-default)
     (require 'company-go)

; NOTE: $ go get -u github.com/rogpeppe/godef
     (define-key go-mode-map (kbd "M-.") 'godef-jump)
     (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)

     (require 'go-eldoc)
     (add-hook 'go-mode-hook 'go-eldoc-setup)

     (company-mode)
     (setq company-idle-delay 0)
     (setq completion-ignore-case t)
     (setq company-selection-wrap-around t)))

; NOTE: $ go get golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

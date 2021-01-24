(use-package go-mode
  ; NOTE: $ go get golang.org/x/tools/cmd/goimports
  :init (subword-mode 1)
        (setq gofmt-command "goimports")
  :config (use-package go-autocomplete)
          (ac-config-default)
          (use-package company-go)
          (use-package go-eldoc)
  :hook (go-mode . #'go-eldoc-setup)
        (go-mode . #'gofmt-before-save)
  ; NOTE: $ go get -u github.com/rogpeppe/godef
  :bind
  (:map go-mode-map ("M-." . godef-jump)
                    ("M-," . pop-tag-mark)))


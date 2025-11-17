(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp-deferred)
  :config (add-to-list 'lsp-enabled-clients 'dart_analysis_server))
  ;; :bind (("M-l d c" . "lsp-dart-run-test-at-point")
  ;;        ("M-l d T" . "lsp-dart-run-test-file")))

(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp-deferred)
  :config (add-to-list 'lsp-enabled-clients 'dart_analysis_server)
          (setq dart-enable-analysis-server t)
          (setq dart-format-on-save t))

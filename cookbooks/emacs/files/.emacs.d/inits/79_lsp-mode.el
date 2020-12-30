(use-package lsp-mode
    :hook ((lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)

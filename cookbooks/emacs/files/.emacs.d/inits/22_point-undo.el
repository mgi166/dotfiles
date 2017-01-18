;; point-undo (ポイントの位置を undo する)
(require 'point-undo)
(define-key global-map [f5] 'point-undo)
(define-key global-map [f6] 'point-redo)

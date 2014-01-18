(require 'cl)
(require 'json)

(defvar my-frame-size-hash
  "initialize hash for memorize frame size of configuration"
  (make-hash-table :test 'equal))

(defun set-my-frame-size (path)
  (setq frame-size-hash (json-read-file path)))

(provide 'my-frame)

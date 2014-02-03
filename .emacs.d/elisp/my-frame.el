(require 'cl)
(require 'json)

(defun set-my-frame-size (path)
  (setq frame-size-hash (json-read-file path)))

(provide 'my-frame)

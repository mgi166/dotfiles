(require 'cl)
(require 'json)

(defvar frame-size-hash
  "initialize hash for memorize frame size of configuration"
  (make-hash-table :test 'equal))

;; functions by rubikichi (http://d.hatena.ne.jp/rubikitch/20100201/elispsyntax)
(defun print-hash (hash)
  (with-temp-buffer
    (loop initially (insert "{")
          for k being the hash-keys in hash using (hash-values v) do
          (insert " " (prin1-to-string k) " => " (prin1-to-string v) ",")
          finally   (delete-backward-char 2) (insert " }"))
    (buffer-string)))

(defun print-keys (hash)
  (loop for k being the hash-keys in hash collect k))

(defun print-values (hash)
  (loop for v being the hash-values in hash collect v))
;;

(setq hash (make-hash-table :test 'equal))

(defun extract-elements (str)
  "return extract inner string '{' to '}'"
  (string-match "{\\(.*\\)}" str)
  (match-string 1 str))

(defun split-comma (str)
  "return element that string split ','"
  (split-string str ","))

(defun split-colon (str)
  "return cons that string split ':'"
  (split-string str ":"))

(defun remove-blank (str)
  "remove newline and space and tab"
  (replace-regexp-in-string "\\s-\\|\n" "" str))

(defun pair-element (str)
  "return pair element key and value"
  (mapcar 'remove-blank (split-colon str)))

(defun push-hash (list)
  "return hash that has the key of list car and the value of list cdr"
  (puthash (car list) (cdr list) hash))

(defun parse-elements (str)
  (loop for ele in (split-comma str)
		do (push-hash
			(pair-element ele))
))

(setq frame-size-hash (json-read-file "~/.emacs.d/frame/frame.json"))

(provide 'frame)

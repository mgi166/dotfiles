(require 'string-inflection)

(defun string-inflection-my-cycle-function (str)
  "foo_bar => fooBar => FOO_BAR => foo_bar"
  (cond
   ((string-inflection-underscore-p str)
    (string-inflection-camelcase-function str))
   ((string-inflection-camelcase-p str)
    (string-inflection-upcase-function str))
   (t
    (string-inflection-underscore-function str))))

(defun my/string-inflection-my-style-cycle ()
  (interactive)
  (string-inflection-insert
   (string-inflection-my-cycle-function (string-inflection-get-current-word))))

(global-set-key (kbd "C-c C-u") 'my/string-inflection-my-style-cycle)

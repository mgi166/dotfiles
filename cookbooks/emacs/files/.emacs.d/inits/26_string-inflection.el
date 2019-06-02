(require 'string-inflection)

  "foo_bar => fooBar => FOO_BAR => foo_bar"
(defun my/string-inflection-cycle-function (str)
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
   (my/string-inflection-cycle-function (string-inflection-get-current-word))))

(global-set-key (kbd "C-c C-u") 'my/string-inflection-my-style-cycle)

(use-package string-inflection
  :ensure t)

(defun my/string-inflection-cycle-function (str)
  "foo_bar => fooBar => FooBar => FOO_BAR => foo_bar"
  (cond
   ((string-inflection-underscore-p str)
    (string-inflection-camelcase-function str))
   ((string-inflection-camelcase-p str)
    (string-inflection-pascal-case-function str))
   ((string-inflection-pascal-case-p str)
    (string-inflection-upcase-function str))
   (t
    (string-inflection-underscore-function str))))

(defun my/string-inflection-my-style-cycle ()
  (interactive)
  (string-inflection-insert
   (my/string-inflection-cycle-function (string-inflection-get-current-word))))

(global-set-key (kbd "C-c C-u") 'my/string-inflection-my-style-cycle)

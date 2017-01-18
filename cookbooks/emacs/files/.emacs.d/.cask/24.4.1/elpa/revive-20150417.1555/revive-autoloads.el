;;; revive-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "revive" "revive.el" (22414 13325 0 0))
;;; Generated autoloads from revive.el

(autoload 'current-window-configuration-printable "revive" "\
Return the printable current-window-configuration.
This configuration will be stored by restore-window-configuration.
Returned configurations are list of:
'(Screen-Width Screen-Height Edge-List Buffer-List)

Edge-List is a return value of revive:all-window-edges, list of all
window-edges whose first member is always of north west window.

Buffer-List is a list of buffer property list of all windows.  This
property lists are stored in order corresponding to Edge-List.  Buffer
property list is formed as
'((buffer-file-name) (buffer-name) (point) (window-start)).

\(fn)" nil nil)

(autoload 'restore-window-configuration "revive" "\
Restore the window configuration.
Configuration CONFIG should be created by
current-window-configuration-printable.

\(fn CONFIG)" nil nil)

(autoload 'wipe "revive" "\
Wipe Emacs.

\(fn)" t nil)

(autoload 'save-current-configuration "revive" "\
Save current window/buffer configuration into configuration file.

\(fn &optional NUM)" t nil)

(autoload 'resume "revive" "\
Resume window/buffer configuration.
Configuration should be saved by save-current-configuration.

\(fn &optional NUM)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; revive-autoloads.el ends here

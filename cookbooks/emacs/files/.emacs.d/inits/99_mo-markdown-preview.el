;;; 99_mo-markdown-preview.el --- Markdown preview using mo -*- lexical-binding: t -*-
;;
;; Description: Minor mode for Markdown live preview using mo.
;; mo: https://github.com/k1LoW/mo
;;
;; mo runs as a background server and watches files via filesystem events.
;; Saving the buffer is sufficient to trigger browser refresh.

(defgroup mo-markdown-preview nil
  "Markdown preview using mo."
  :group 'markdown)

(defcustom mo-markdown-preview-command "mo"
  "Command to run the mo markdown previewer."
  :type 'string
  :group 'mo-markdown-preview)

(defcustom mo-markdown-preview-port 6275
  "Port on which the mo server listens."
  :type 'integer
  :group 'mo-markdown-preview)

(defcustom mo-markdown-preview-open-delay 0.5
  "Seconds to wait after launching mo before opening the browser.
A small delay ensures the server is ready when it starts for the first time."
  :type 'number
  :group 'mo-markdown-preview)

(defcustom mo-markdown-preview-idle-delay 1.5
  "Idle delay in seconds before auto-saving to update the mo preview.
When non-nil, the buffer is automatically saved after this many seconds
of idle time, allowing mo to pick up unsaved changes.
Set to nil to disable idle-based auto-save (manual save only)."
  :type '(choice (number :tag "Delay in seconds")
                 (const :tag "Disabled (manual save only)" nil))
  :group 'mo-markdown-preview)

(defvar-local mo-markdown-preview--idle-timer nil
  "Per-buffer idle timer for auto-save.")

;;;###autoload
(define-minor-mode mo-markdown-preview-mode
  "Minor mode to preview Markdown files using mo.

When enabled:
- If `mo-markdown-preview-idle-delay' is set, auto-saves on idle so mo
  picks up unsaved changes automatically.
- Use `mo-markdown-preview-open' (\\[mo-markdown-preview-open]) to open
  the current file in the browser."
  :lighter " MoPrev"
  :group 'mo-markdown-preview
  (if mo-markdown-preview-mode
      (mo-markdown-preview--start)
    (mo-markdown-preview--stop)))

(defun mo-markdown-preview--start ()
  "Set up idle-save timer for the current buffer."
  (unless (buffer-file-name)
    (setq mo-markdown-preview-mode nil)
    (user-error "mo-markdown-preview: buffer must be visiting a file"))
  (when mo-markdown-preview-idle-delay
    (setq mo-markdown-preview--idle-timer
          (run-with-idle-timer mo-markdown-preview-idle-delay t
                               #'mo-markdown-preview--maybe-save (current-buffer)))))

;;;###autoload
(defun mo-markdown-preview-open ()
  "Open the current Markdown buffer in mo.
Saves the buffer first if it has unsaved changes."
  (interactive)
  (unless (buffer-file-name)
    (user-error "mo-markdown-preview: buffer must be visiting a file"))
  (unless (executable-find mo-markdown-preview-command)
    (user-error "mo-markdown-preview: '%s' not found in PATH" mo-markdown-preview-command))
  (when (buffer-modified-p)
    (save-buffer))
  (mo-markdown-preview--launch (buffer-file-name)))

(defun mo-markdown-preview--stop ()
  "Stop the mo preview for the current buffer."
  (when mo-markdown-preview--idle-timer
    (cancel-timer mo-markdown-preview--idle-timer)
    (setq mo-markdown-preview--idle-timer nil))
  (message "mo-markdown-preview: stopped"))

(defun mo-markdown-preview--launch (file)
  "Add FILE to mo server, then open the browser after a short delay."
  (start-process "mo-markdown-preview" nil mo-markdown-preview-command file)
  (run-with-timer mo-markdown-preview-open-delay nil
                  #'mo-markdown-preview--open-browser)
  (message "mo-markdown-preview: opened %s" (file-name-nondirectory file)))

(defun mo-markdown-preview--open-browser ()
  "Open the mo server URL in the browser."
  (browse-url (format "http://localhost:%d" mo-markdown-preview-port)))

(defun mo-markdown-preview--maybe-save (buffer)
  "Save BUFFER if modified, so mo can pick up the latest changes."
  (when (and (buffer-live-p buffer)
             (buffer-modified-p buffer)
             (buffer-file-name buffer))
    (with-current-buffer buffer
      (save-buffer))))

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-c C-p") #'mo-markdown-preview-open))

(add-hook 'markdown-mode-hook #'mo-markdown-preview-mode)

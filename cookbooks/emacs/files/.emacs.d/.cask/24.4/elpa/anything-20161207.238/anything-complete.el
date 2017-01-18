;;; anything-complete.el --- completion with anything
;; $Id: anything-complete.el,v 1.86 2010-03-31 23:14:13 rubikitch Exp $

;; Copyright (C) 2008, 2009, 2010, 2011 rubikitch

;; Author: rubikitch <rubikitch@ruby-lang.org>
;; Keywords: matching, convenience, anything
;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/anything-complete.el

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Completion with Anything interface.

;;; Commands:
;;
;; Below are complete command list:
;;
;;  `alcs-update-restart'
;;    Update lisp symbols and restart current `anything' session.
;;  `anything-lisp-complete-symbol'
;;    `lisp-complete-symbol' replacement using `anything'.
;;  `anything-lisp-complete-symbol-partial-match'
;;    `lisp-complete-symbol' replacement using `anything' (partial match).
;;  `anything-apropos'
;;    `apropos' replacement using `anything'.
;;  `anything-read-string-mode'
;;    If this minor mode is on, use `anything' version of `completing-read' and `read-file-name'.
;;  `anything-complete-shell-history'
;;    Select a command from shell history and insert it.
;;  `anything-execute-extended-command'
;;    Replacement of `execute-extended-command'.
;;
;;; Customizable Options:
;;
;; Below are customizable option list:
;;
;;  `anything-complete-sort-candidates'
;;    *Whether to sort completion candidates.
;;    default = nil
;;  `anything-execute-extended-command-use-kyr'
;;    *Use `anything-kyr' (context-aware commands) in `anything-execute-extended-command'.
;;    default = t

;; * `anything-lisp-complete-symbol', `anything-lisp-complete-symbol-partial-match':
;;     `lisp-complete-symbol' with `anything'
;; * `anything-apropos': `apropos' with `anything'
;; * `anything-complete-shell-history': complete from .*sh_history
;; * Many read functions:
;;     `anything-read-file-name', `anything-read-buffer', `anything-read-variable',
;;     `anything-read-command', `anything-completing-read'
;; * `anything-read-string-mode' replaces default read functions with anything ones.
;; * Many anything sources:
;;     [EVAL IT] (occur "defvar anything-c-source")

;;; Installation:

;; Put anything-complete.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; Then install dependencies.
;;
;; Install anything-match-plugin.el (must).
;; M-x install-elisp http://www.emacswiki.org/cgi-bin/wiki/download/anything-match-plugin.el
;;
;; shell-history.el / shell-command.el would help you (optional).
;; M-x install-elisp http://www.emacswiki.org/cgi-bin/wiki/download/shell-history.el
;; M-x install-elisp http://www.emacswiki.org/cgi-bin/wiki/download/shell-command.el
;;
;; If you want `anything-execute-extended-command' to show
;; context-aware commands, use anything-kyr.el and
;; anything-kyr-config.el (optional).
;;
;; M-x install-elisp http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr.el
;; M-x install-elisp http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr-config.el

;; And the following to your ~/.emacs startup file.
;;
;; (require 'anything-complete)
;; ;; Automatically collect symbols by 150 secs
;; (anything-lisp-complete-symbol-set-timer 150)
;; (define-key emacs-lisp-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
;; (define-key lisp-interaction-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
;; ;; replace completion commands with `anything'
;; (anything-read-string-mode 1)
;; ;; Bind C-o to complete shell history
;; (anything-complete-shell-history-setup-key "\C-o")

;;; Change log:
;;
;;  Change log of this file is found at
;;  http://repo.or.cz/w/anything-config.git/history/master:/anything-complete.el
;;
;;  Change log of this project is found at
;;  http://repo.or.cz/w/anything-config.git?a=shortlog


;;; Code:

(defvar anything-complete-version "20161203")
(require 'anything-match-plugin)
(require 'thingatpt)
(require 'anything-obsolete)


;; (@* "overlay")
(when (require 'anything-show-completion nil t)
  (dolist (f '(anything-complete
               anything-lisp-complete-symbol
               anything-lisp-complete-symbol-partial-match))
    (use-anything-show-completion f '(length anything-complete-target))))

;; (@* "core")
(defvar anything-complete-target "")

(defun ac-insert (candidate)
  (let ((pt (point)))
    (when (and (search-backward anything-complete-target nil t)
               (string= (buffer-substring (point) pt) anything-complete-target))
      (delete-region (point) pt)))
  (insert candidate))

(define-anything-type-attribute 'complete
  '((candidates-in-buffer)
    (action . ac-insert)))

;; Warning: I'll change this function's interface. DON'T USE IN YOUR PROGRAM!
(defun anything-noresume (&optional any-sources any-input any-prompt any-resume any-preselect any-buffer)
  (let (anything-last-sources anything-compiled-sources anything-last-buffer)
    (anything any-sources any-input any-prompt 'noresume any-preselect any-buffer)))

(defun anything-complete (sources target &optional limit idle-delay input-idle-delay)
  "Basic completion interface using `anything'."
  (let ((anything-candidate-number-limit (or limit anything-candidate-number-limit))
        (anything-idle-delay (or idle-delay anything-idle-delay))
        (anything-input-idle-delay (or input-idle-delay anything-input-idle-delay))
        (anything-complete-target target)
        (anything-execute-action-at-once-if-one t)
        (enable-recursive-minibuffers t)
        anything-samewindow)
    (anything-noresume sources target nil nil nil "*anything complete*")))

;; (@* "`lisp-complete-symbol' and `apropos' replacement")
(defvar anything-lisp-complete-symbol-input-idle-delay 0.1
  "`anything-input-idle-delay' for `anything-lisp-complete-symbol',
`anything-lisp-complete-symbol-partial-match' and `anything-apropos'.")
(defvar anything-lisp-complete-symbol-add-space-on-startup t
  "If non-nil, `anything-lisp-complete-symbol' and `anything-lisp-complete-symbol-partial-match' adds space on startup.
It utilizes anything-match-plugin's feature.")

(defun alcs-create-buffer (name)
  (let ((b (get-buffer-create name)))
    (with-current-buffer b
      (buffer-disable-undo)
      (erase-buffer)
      b)))

(defvar alcs-variables-buffer " *variable symbols*")
(defvar alcs-functions-buffer " *function symbols*")
(defvar alcs-commands-buffer " *command symbols*")
(defvar alcs-faces-buffer " *face symbols*")
(defvar alcs-symbol-buffer " *other symbols*")

(defvar alcs-symbols-time nil
  "Timestamp of collected symbols")

(defun alcs-make-candidates-internal (bufname predicate)
  (save-excursion
    (let ((inhibit-read-only t))
      (setq alcs-symbols-time (current-time))
      (set-buffer (alcs-create-buffer bufname))
      (insert (mapconcat 'identity (all-completions "" obarray predicate) "\n")))))
(defun alcs-make-candidates--commands ()
  (alcs-make-candidates-internal alcs-commands-buffer 'commandp))
(defun alcs-make-candidates--functions ()
  (alcs-make-candidates-internal alcs-functions-buffer 'fboundp))
(defun alcs-make-candidates--variables ()
  (alcs-make-candidates-internal alcs-variables-buffer 'boundp))
(defun alcs-make-candidates--faces ()
  (alcs-make-candidates-internal alcs-faces-buffer 'facep))
(defun alcs-make-candidates--symbol ()
  (alcs-make-candidates-internal alcs-symbol-buffer nil))

(defun alcs-make-candidates ()
  (message "Collecting symbols...")
  ;; To ignore read-only property.
  (alcs-make-candidates--commands)
  (alcs-make-candidates--functions)
  (alcs-make-candidates--variables)
  (alcs-make-candidates--faces)
  (alcs-make-candidates--symbol)
  (message "Collecting symbols...done"))

(defun alcs-header-name (name)
  (format "%s at %s (Press `C-c C-u' to update)"
          name (format-time-string "%H:%M:%S" alcs-symbols-time)))

(defvar alcs-make-candidates-timer nil)
(defun anything-lisp-complete-symbol-set-timer (update-period)
  "Update Emacs symbols list when Emacs is idle,
used by `anything-lisp-complete-symbol-set-timer' and `anything-apropos'"
  (when alcs-make-candidates-timer
    (cancel-timer alcs-make-candidates-timer))
  (setq alcs-make-candidates-timer
        (run-with-idle-timer update-period update-period 'alcs-make-candidates)))

(defvar alcs-physical-column-at-startup nil)
(defun alcs-init (bufname)
  (declare (special anything-dabbrev-last-target))
  (setq alcs-physical-column-at-startup nil)
  (setq anything-complete-target
        (if (loop for src in (anything-get-sources)
                  thereis (string-match "^dabbrev" (assoc-default 'name src)))
            anything-dabbrev-last-target
          (or (tap-symbol) "")))
  (anything-candidate-buffer (get-buffer bufname)))

(defcustom anything-complete-sort-candidates nil
  "*Whether to sort completion candidates."
  :type 'boolean
  :group 'anything-complete)

(defcustom anything-execute-extended-command-use-kyr t
  "*Use `anything-kyr' (context-aware commands) in `anything-execute-extended-command'. "
  :type 'boolean
  :group 'anything-complete)
(defun alcs-sort-maybe (candidates source)
  (if anything-complete-sort-candidates
      (sort candidates #'string<)
    candidates))
(defun alcs-fontify-face (candidates source)
  (mapcar
   (lambda (facename)
     (propertize facename 'face (intern-soft facename)))
   candidates))
;;; borrowed from pulldown.el
(defun alcs-current-physical-column ()
  "Current physical column. (not logical column)"
  ;; (- (point) (save-excursion (vertical-motion 0) (point)))
  (car (posn-col-row (posn-at-point))))

(defun alcs-transformer-prepend-spacer (candidates source)
  "Prepend spaces according to `current-column' for each CANDIDATES."
  (setq alcs-physical-column-at-startup
        (or alcs-physical-column-at-startup
            (with-current-buffer anything-current-buffer
              (save-excursion
                (backward-char (string-width anything-complete-target))
                (max 0
                     (- (alcs-current-physical-column)
                        (if (buffer-local-value 'anything-enable-shortcuts (get-buffer anything-buffer))
                            4           ;length of shortcut overlay
                          0)))))))
  (mapcar (lambda (cand) (cons (concat (make-string alcs-physical-column-at-startup ? ) cand) cand))
          candidates))

(defun alcs-transformer-prepend-spacer-maybe (candidates source)
  ;; `anything-show-completion-activate' is defined in anything-show-completion.el
  (if (and (boundp 'anything-show-completion-activate)
           anything-show-completion-activate)
      (alcs-transformer-prepend-spacer candidates source)
    candidates))

(defun alcs-describe-function (name)
  (describe-function (anything-c-symbolify name)))
(defun alcs-describe-variable (name)
  (with-current-buffer anything-current-buffer
    (describe-variable (anything-c-symbolify name))))
(defun alcs-describe-face (name)
  (describe-face (anything-c-symbolify name)))
(defun alcs-customize-face (name)
  (customize-face (anything-c-symbolify name)))
(defun alcs-find-function (name)
  (find-function (anything-c-symbolify name)))
(defun alcs-find-variable (name)
  (find-variable (anything-c-symbolify name)))

(defvar anything-c-source-complete-emacs-functions
  '((name . "Functions")
    (init . (lambda () (alcs-init alcs-functions-buffer)))
    (candidates-in-buffer)
    (type . complete-function)))
(defvar anything-c-source-complete-emacs-commands
  '((name . "Commands")
    (init . (lambda () (alcs-init alcs-commands-buffer)))
    (candidates-in-buffer)
    (type . complete-function)))
(defvar anything-c-source-complete-emacs-variables
  '((name . "Variables")
    (init . (lambda () (alcs-init alcs-variables-buffer)))
    (candidates-in-buffer)
    (type . complete-variable)))
(defvar anything-c-source-complete-emacs-faces
  '((name . "Faces")
    (init . (lambda () (alcs-init alcs-faces-buffer)))
    (candidates-in-buffer)
    (type . complete-face)))
(defvar anything-c-source-complete-emacs-other-symbols
  '((name . "Other Symbols")
    (init . (lambda () (alcs-init alcs-symbol-buffer)))
    (candidates-in-buffer)
    (filtered-candidate-transformer . alcs-sort-maybe)
    (action . ac-insert)))
(defvar anything-c-source-apropos-emacs-functions
  '((name . "Apropos Functions")
    (init . (lambda () (alcs-init alcs-functions-buffer)))
    (candidates-in-buffer)
    (requires-pattern . 3)
    (type . apropos-function)))
(defvar anything-c-source-apropos-emacs-commands
  '((name . "Apropos Commands")
    (init . (lambda () (alcs-init alcs-commands-buffer)))
    (candidates-in-buffer)
    (requires-pattern . 3)
    (type . apropos-function)))
(defvar anything-c-source-apropos-emacs-variables
  '((name . "Apropos Variables")
    (init . (lambda () (alcs-init alcs-variables-buffer)))
    (candidates-in-buffer)
    (requires-pattern . 3)
    (type . apropos-variable)))
(defvar anything-c-source-apropos-emacs-faces
  '((name . "Apropos Faces")
    (init . (lambda () (alcs-init alcs-faces-buffer)))
    (candidates-in-buffer)
    (requires-pattern . 3)
    (type . apropos-face)))
(defvar anything-c-source-emacs-function-at-point
  '((name . "Function at point")
    (candidates
     . (lambda () (with-current-buffer anything-current-buffer
                    (anything-aif (function-called-at-point)
                        (list (symbol-name it))))))
    (type . apropos-function)))
(defvar anything-c-source-emacs-variable-at-point
  '((name . "Variable at point")
    (candidates
     . (lambda () (with-current-buffer anything-current-buffer
                    (anything-aif (variable-at-point)
                        (unless (equal 0 it) (list (symbol-name it)))))))
    (type . apropos-variable)))
(defvar anything-c-source-emacs-face-at-point
  '((name . "Face at point")
    (candidates
     . (lambda () (with-current-buffer anything-current-buffer
                    (anything-aif (face-at-point)
                        (unless (equal 0 it) (list (symbol-name it)))))))
    (type . apropos-variable)))

(defvar anything-lisp-complete-symbol-sources
  '(anything-c-source-complete-anything-attributes
    anything-c-source-complete-emacs-commands
    anything-c-source-complete-emacs-functions
    anything-c-source-complete-emacs-variables
    anything-c-source-complete-emacs-faces))

(defvar anything-apropos-sources
  '(anything-c-source-emacs-function-at-point
    anything-c-source-emacs-variable-at-point
    anything-c-source-apropos-emacs-commands
    anything-c-source-apropos-emacs-functions
    anything-c-source-apropos-emacs-variables
    anything-c-source-apropos-emacs-faces))

(define-anything-type-attribute 'apropos-function
  '((filtered-candidate-transformer . alcs-sort-maybe)
    (header-name . alcs-header-name)
    (persistent-action . alcs-describe-function)
    (update . alcs-make-candidates--functions)
    (action
     ("Describe Function" . alcs-describe-function)
     ("Find Function" . alcs-find-function))))
(define-anything-type-attribute 'apropos-variable
  '((filtered-candidate-transformer . alcs-sort-maybe)
    (header-name . alcs-header-name)
    (persistent-action . alcs-describe-variable)
    (update . alcs-make-candidates--variables)
    (action
     ("Describe Variable" . alcs-describe-variable)
     ("Find Variable" . alcs-find-variable))))
(define-anything-type-attribute 'apropos-face
  '((filtered-candidate-transformer alcs-sort-maybe alcs-fontify-face)
    (get-line . buffer-substring)
    (header-name . alcs-header-name)
    (update . alcs-make-candidates--faces)
    (persistent-action . alcs-describe-face)
    (action
     ("Customize Face" . alcs-customize-face)
     ("Describe Face" . alcs-describe-face))))
(define-anything-type-attribute 'complete-function
  '((filtered-candidate-transformer alcs-sort-maybe alcs-transformer-prepend-spacer-maybe)
    (header-name . alcs-header-name)
    (action . ac-insert)
    (update . alcs-make-candidates--functions)
    (persistent-action . alcs-describe-function)))
(define-anything-type-attribute 'complete-variable
  '((filtered-candidate-transformer alcs-sort-maybe alcs-transformer-prepend-spacer-maybe)
    (header-name . alcs-header-name)
    (action . ac-insert)
    (update . alcs-make-candidates--variables)
    (persistent-action . alcs-describe-variable)))
(define-anything-type-attribute 'complete-face
  '((filtered-candidate-transformer alcs-sort-maybe alcs-transformer-prepend-spacer-maybe)
    (header-name . alcs-header-name)
    (action . ac-insert)
    (update . alcs-make-candidates--faces)
    (persistent-action . alcs-describe-face)))

(defvar alcs-this-command nil)
(defun* anything-lisp-complete-symbol-1 (update sources input &optional (buffer "*anything complete*"))
  (setq alcs-this-command this-command)
  (when (or update (null (get-buffer alcs-variables-buffer)))
    (alcs-make-candidates))
  (let (anything-samewindow
        (anything-input-idle-delay
         (or anything-lisp-complete-symbol-input-idle-delay
             anything-input-idle-delay)))
    (funcall
     (if (equal buffer "*anything complete*") 'anything-noresume 'anything)
     sources input nil nil nil buffer)))

;; Test alcs-update-restart (with-current-buffer alcs-commands-buffer (erase-buffer))
;; Test alcs-update-restart (kill-buffer alcs-commands-buffer)
(defun alcs-update-restart ()
  "Update lisp symbols and restart current `anything' session."
  (interactive)
  (alcs-make-candidates)
  (anything-update))

(defun tap-symbol ()
  "Get symbol name before point."
  (save-excursion
    (let ((beg (point)))
      ;; older regexp "\(\\|\\s-\\|^\\|\\_<\\|\r\\|'\\|#'"
      (when (re-search-backward "\\_<" (point-at-bol) t)
        (buffer-substring-no-properties beg (match-end 0))))))

(defun alcs-initial-input (partial-match)
  (anything-aif (tap-symbol)
      (format "%s%s%s"
              (if partial-match "" "^")
              it
              (if anything-lisp-complete-symbol-add-space-on-startup " " ""))
    ""))

(defun anything-lisp-complete-symbol (update)
  "`lisp-complete-symbol' replacement using `anything'."
  (interactive "P")
  (anything-lisp-complete-symbol-1 update anything-lisp-complete-symbol-sources
                                   (alcs-initial-input nil)))
(defun anything-lisp-complete-symbol-partial-match (&optional update)
  "`lisp-complete-symbol' replacement using `anything' (partial match)."
  (interactive "P")
  (anything-lisp-complete-symbol-1 update anything-lisp-complete-symbol-sources
                                   (alcs-initial-input t)))
(defun anything-apropos (update)
  "`apropos' replacement using `anything'."
  (interactive "P")
  (anything-lisp-complete-symbol-1 update anything-apropos-sources nil "*anything apropos*"))

;; (@* "anything attribute completion")
(defvar anything-c-source-complete-anything-attributes
  '((name . "Anything Attributes")
    (candidates . acaa-candidates)
    (action . ac-insert)
    (persistent-action . acaa-describe-anything-attribute)
    (filtered-candidate-transformer alcs-sort-maybe alcs-transformer-prepend-spacer-maybe)
    (header-name . alcs-header-name)
    (action . ac-insert)))
;; (anything 'anything-c-source-complete-anything-attributes)

(defun acaa-describe-anything-attribute (str)
  (anything-describe-anything-attribute (anything-c-symbolify str)))

(defun acaa-candidates ()
  (with-current-buffer anything-current-buffer
    (when (and (require 'yasnippet nil t)
               (acaa-completing-attribute-p (point)))
      (mapcar 'symbol-name anything-additional-attributes))))

(defvar acaa-anything-commands-regexp
  (concat "(" (regexp-opt
               '("anything" "anything-other-buffer"
                 "define-anything-type-attribute" "anything-c-arrange-type-attribute"))
          " "))

(defun acaa-completing-attribute-p (point)
  (save-excursion
    (goto-char point)
    (ignore-errors
      (or (save-excursion
            (backward-up-list 3)
            (looking-at (concat "(defvar anything-c-source-"
                                "\\|"
                                acaa-anything-commands-regexp)))
          (save-excursion
            (backward-up-list 4)
            (looking-at acaa-anything-commands-regexp))))))

;; (anything '(ini
;;;; unit test
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el")
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-mock.el")
(dont-compile
  (when (fboundp 'expectations)
    (expectations
      (desc "acaa-completing-attribute-p")
      (expect t
        (with-temp-buffer
          (insert "(anything '(((na")
          (acaa-completing-attribute-p (point))))
      (expect t
        (with-temp-buffer
          (insert "(anything '((na")
          (acaa-completing-attribute-p (point))))
      (expect nil
        (with-temp-buffer
          (insert "(anything-hoge '((na")
          (acaa-completing-attribute-p (point))))
      (expect nil
        (with-temp-buffer
          (insert "(anything-hoge '(((na")
          (acaa-completing-attribute-p (point))))
      (expect t
        (with-temp-buffer
          (insert "(defvar anything-c-source-hoge '((na")
          (acaa-completing-attribute-p (point))))

      )))

;; (@* "anything-read-string-mode / read-* compatibility functions")
;; moved from anything.el
(defun anything-compile-source--default-value (source)
  (anything-aif (assoc-default 'default-value source)
      (append source
              `((candidates ,it)
                (filtered-candidate-transformer
                 . (lambda (cands source)
                     (if (string= anything-pattern "") cands nil)))))
    source))
(add-to-list 'anything-compile-source-functions 'anything-compile-source--default-value)

;; (@* "`anything-read-string-mode' initialization")
(defvar anything-read-string-mode nil)
(defvar anything-read-string-mode-flags '(string buffer variable command)
  "Saved ARG of `anything-read-string-mode'.")
(defun anything-read-string-mode (arg)
  "If this minor mode is on, use `anything' version of `completing-read' and `read-file-name'.

ARG also accepts a symbol list. The elements are:
string:   replace `completing-read' except `read-file-name'
command:  replace M-x
file:     replace `read-file-name' (disabled by default)

So, (anything-read-string-mode 1) and
 (anything-read-string-mode '(string buffer variable command) are identical.

It is deprecated now, fall back to `anything-completion-mode'
because it is better implementation."
  (interactive "P")
  (when (consp anything-read-string-mode)
    (anything-read-string-mode-uninstall))
  (setq anything-read-string-mode
        (cond ((consp arg) (setq anything-read-string-mode-flags arg)) ; not interactive
              (arg (> (prefix-numeric-value arg) 0))  ; C-u M-x
              (t   (not anything-read-string-mode)))) ; M-x
  (when (eq anything-read-string-mode t)
    (setq anything-read-string-mode anything-read-string-mode-flags))
  (if anything-read-string-mode
      (anything-read-string-mode-install)
    (anything-read-string-mode-uninstall)))

(defun anything-read-string-mode-install ()
  ;; redefine to anything version
  (setq anything-completion-types
        (if (memq 'file anything-read-string-mode)
            '(complete file) '(complete)))
  (anything-completion-mode 1)
  (when (memq 'command anything-read-string-mode)
    (substitute-key-definition 'execute-extended-command 'anything-execute-extended-command global-map))
  (message "Installed anything version of read functions."))
(defun anything-read-string-mode-uninstall ()
  ;; restore to original version
  (anything-completion-mode -1)
  (substitute-key-definition 'anything-execute-extended-command 'execute-extended-command global-map)
  (substitute-key-definition 'anything-find-file 'find-file global-map)
  (message "Uninstalled anything version of read functions."))


;; (@* " shell history")
(defun anything-complete-shell-history ()
  "Select a command from shell history and insert it."
  (interactive)
  (let ((anything-show-completion-minimum-window-height (/ (frame-height) 2)))
    (anything-complete 'anything-c-source-complete-shell-history
                      (or (word-at-point) "")
                      20)))
(defun anything-complete-shell-history-setup-key (key)
  ;; for Emacs22
  (when (and (not (boundp 'minibuffer-local-shell-command-map))
             (require 'shell-command nil t)
             (boundp 'shell-command-minibuffer-map))
    (shell-command-completion-mode)
    (define-key shell-command-minibuffer-map key 'anything-complete-shell-history))
  ;; for Emacs23
  (when (boundp 'minibuffer-local-shell-command-map)
    (define-key minibuffer-local-shell-command-map key 'anything-complete-shell-history))

  (when (require 'background nil t)
    (define-key background-minibuffer-map key 'anything-complete-shell-history))
  (require 'shell)
  (define-key shell-mode-map key 'anything-complete-shell-history))

(defvar zsh-p nil)
(defvar anything-c-source-complete-shell-history
  '((name . "Shell History")
    (init . (lambda ()
              (require 'shell-history)
              (with-current-buffer (anything-candidate-buffer (shell-history-buffer))
                (revert-buffer t t)
                (set (make-local-variable 'zsh-p)
                     (shell-history-zsh-extended-history-p)))))
    (get-line . acsh-get-line)
    (search-from-end)
    (type . complete)))

(defun acsh-get-line (s e)
  (let ((extended-history (string= (buffer-substring s (+ s 2)) ": "))
        (single-line (not (string= (buffer-substring (1- e) e) "\\"))))
    (cond ((not zsh-p)
           (buffer-substring s e))
          ((and extended-history single-line)
           (buffer-substring (+ s 15) e))
          (extended-history             ;zsh multi-line / 1st line
           (goto-char e)
           (let ((e2 (1- (if (re-search-forward "^: [0-9]+:[0-9];" nil t)
                             (match-beginning 0)
                           (point-max)))))
             (prog1 (replace-regexp-in-string
                     "\\\\\n" ";" (buffer-substring (+ s 15) e2))
               (goto-char s))))
          (t                   ; zsh multi-line history / not 1st line
           (goto-char s)
           (re-search-backward "^: [0-9]+:[0-9];" nil t)
           (let ((s2 (match-end 0)) e2)
             (goto-char s2)
             (setq e2 (1- (if (re-search-forward "^: [0-9]+:[0-9];" nil t)
                              (match-beginning 0)
                            (point-max))))
             (prog1 (replace-regexp-in-string
                     "\\\\\n" ";" (buffer-substring s2 e2))
               (goto-char s2)))))))

;;;; M-x
(defvar anything-execute-extended-command-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map anything-map)
    (define-key map (kbd "M-x") 'anything-next-line)
    map))

(define-anything-type-attribute 'execute-command
  `((update . alcs-make-candidates--commands)
    (keymap . ,anything-execute-extended-command-map)
    (persistent-action . alcs-describe-function)
    (action ("Execute" . anything-execute-extended-command-execute)
            ("Describe Function" . alcs-describe-function)
            ("Find Function" . alcs-find-function))))

;; I do not want to make anything-c-source-* symbols because they are
;; private in `anything-execute-extended-command'.
(defvar anything-execute-extended-command-sources
  '(((name . "Emacs Commands History")
     (candidates . extended-command-history)
     (type . execute-command))
    ((name . "Commands")
     (header-name . alcs-header-name)
     (init . (lambda () (anything-candidate-buffer
                         (get-buffer-create alcs-commands-buffer))))
     (candidates-in-buffer)
     (type . execute-command))
    ((name . "New Command")
     (dummy)
     (type . execute-command))))

;; (with-current-buffer " *command symbols*" (erase-buffer))
(defvar anything-execute-extended-command-prefix-arg nil)

(defun anything-execute-extended-command-execute (cmdname)
  (let ((sym-com (and (stringp cmdname) (intern-soft cmdname))))
    (unless (and sym-com (commandp sym-com))
      (error "No such command: %s" cmdname))
    (setq this-command sym-com
          real-this-command sym-com)
    (let ((prefix-arg anything-execute-extended-command-prefix-arg))
      (setq extended-command-history
            (cons cmdname
                  (delete cmdname extended-command-history)))
      (command-execute sym-com 'record))))

(defun anything-execute-extended-command (arg)
  "Replacement of `execute-extended-command'."
  (interactive "P")
  (setq anything-execute-extended-command-prefix-arg arg)
  (setq alcs-this-command this-command)
  (anything
   (if (and anything-execute-extended-command-use-kyr
            (require 'anything-kyr-config nil t))
       (cons anything-c-source-kyr
             anything-execute-extended-command-sources)
     anything-execute-extended-command-sources)))

(add-hook 'after-init-hook 'alcs-make-candidates)


;;;; unit test
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el")
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-mock.el")
(dont-compile
  (when (fboundp 'expectations)
    (expectations
      (desc "acsh-get-line command")
      (expect "ls"
        (let ((zsh-p t))
          (with-temp-buffer
            (insert ": 1118554690:0;cat ~/.zsh_history\n"
                    ": 1118554690:0;ls\n")
            (forward-line -1)
            (acsh-get-line (point-at-bol) (point-at-eol)))))
      (expect "cd;ls -l"
        (let ((zsh-p t))
          (with-temp-buffer
            (insert ": 1118554690:0;cat ~/.zsh_history\n"
                    ": 1118554690:0;cd\\\n"
                    "ls -l\n"
                    ": 1118554690:0;hoge\n")
            (forward-line -2)
            (acsh-get-line (point-at-bol) (point-at-eol)))))
      (expect "cd;ls -l"
        (let ((zsh-p t))
          (with-temp-buffer
            (insert ": 1118554690:0;cat ~/.zsh_history\n"
                    ": 1118554690:0;cd\\\n"
                    "ls -l\n"
                    ": 1118554690:0;hoge\n")
            (forward-line -3)
            (acsh-get-line (point-at-bol) (point-at-eol)))))
      (expect "cd;ls -l"
        (let ((zsh-p t))
          (with-temp-buffer
            (insert ": 1118554690:0;cat ~/.zsh_history\n"
                    ": 1118554690:0;cd\\\n"
                    "ls -l\n")
            (forward-line -1)
            (acsh-get-line (point-at-bol) (point-at-eol)))))
      (expect "cd;ls -l"
        (let ((zsh-p t))
          (with-temp-buffer
            (insert ": 1118554690:0;cat ~/.zsh_history\n"
                    ": 1118554690:0;cd\\\n"
                    "ls -l\n")
            (forward-line -2)
            (acsh-get-line (point-at-bol) (point-at-eol)))))
      (expect "pwd"
        (let ((zsh-p nil))
          (with-temp-buffer
            (insert "foo\n"
                    "pwd\n")
            (forward-line -1)
            (acsh-get-line (point-at-bol) (point-at-eol)))))
      (desc "acsh-get-line lineno")
      (expect 2
        (let ((zsh-p t))
          (with-temp-buffer
            (insert ": 1118554690:0;cat ~/.zsh_history\n"
                    ": 1118554690:0;cd\\\n"
                    "ls -l\n"
                    ": 1118554690:0;hoge\n")
            (forward-line -2)
            (acsh-get-line (point-at-bol) (point-at-eol))
            (line-number-at-pos))))
      (expect 2
        (let ((zsh-p t))
          (with-temp-buffer
            (insert ": 1118554690:0;cat ~/.zsh_history\n"
                    ": 1118554690:0;cd\\\n"
                    "ls -l\n"
                    ": 1118554690:0;hoge\n")
            (forward-line -3)
            (acsh-get-line (point-at-bol) (point-at-eol))
            (line-number-at-pos))))

      )))

;;; for compatibility
(defvaralias 'anything-c-source-complete-emacs-variables-partial-match
  'anything-c-source-complete-emacs-variables)
(defvaralias 'anything-c-source-complete-emacs-commands-partial-match
  'anything-c-source-complete-emacs-commands)
(defvaralias 'anything-c-source-complete-emacs-functions-partial-match
  'anything-c-source-complete-emacs-functions)



(provide 'anything-complete)

;; How to save (DO NOT REMOVE!!)
;; (progn (magit-push) (emacswiki-post "anything-complete.el"))
;;; anything-complete.el ends here

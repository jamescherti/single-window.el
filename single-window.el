;;; single-window.el --- Always open buffers in the current window -*- lexical-binding: t; -*-

;; Copyright (C) 2026 James Cherti | https://www.jamescherti.com/contact/

;; Author: James Cherti
;; Version: 0.9.9
;; URL: https://github.com/jamescherti/single-window.el
;; Keywords: convenience
;; Package-Requires: ((emacs "24.4"))
;; SPDX-License-Identifier: GPL-3.0-or-later

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; The single-window package forces Emacs to open buffers in the current active
;; window.
;;
;; It keeps your carefully arranged layouts intact, reduces visual clutter, and
;; provides a much more predictable workflow. It also handles edge cases by
;; configuring modes like org-mode (src blocks and agenda) to respect the
;; current window.

;;; Code:

;;; Variables

(defgroup single-window nil
  "Always open buffer in the current window."
  :group 'single-window
  :prefix "single-window-"
  :link '(url-link
          :tag "Github"
          "https://github.com/jamescherti/single-window.el"))

(defcustom single-window-respect-display-buffer-alist nil
  "When non-nil, respect user configurations in `display-buffer-alist'.
If enabled, the strict single-window rule is appended as a fallback, allowing
specific buffer rules to take precedence. If nil, the rule is prepended and
aggressively overrides all other configurations."
  :type 'boolean
  :group 'single-window)

(defcustom single-window-respect-display-buffer-overriding-action t
  "When non-nil, respect `display-buffer-overriding-action'.
If enabled, Emacs prefix commands like `other-window-prefix' (C-x 4 4) will
function normally. If nil, this package will aggressively override modes that
attempt to use this variable to force their own window layouts."
  :type 'boolean
  :group 'single-window)

;; (defcustom single-window-verbose nil
;;   "Enable displaying verbose messages."
;;   :type 'boolean
;;   :group 'single-window)

;;; Internal variables

(defvar org-agenda-window-setup)
(defvar org-indirect-buffer-display)
(defvar org-src-window-setup)
(defvar switch-to-buffer-in-dedicated-window)
(defvar switch-to-buffer-obey-display-actions)
(defvar single-window--save-vars nil)

;;; Functions

;; (defun single-window--message (&rest args)
;;   "Display a message with the same ARGS arguments as `message'."
;;   (apply #'message (concat "[single-window] " (car args)) (cdr args)))
;;
;; (defmacro single-window--verbose-message (&rest args)
;;   "Display a verbose message with the same ARGS arguments as `message'."
;;   (declare (indent 0) (debug t))
;;   `(progn
;;      (when single-window-verbose
;;        (single-window--message
;;         (concat ,(car args)) ,@(cdr args)))))

(defun single-window--force-single-window-advice (orig-fun &rest args)
  "Advice to force functions to open in the current window.
ORIG-FUN is the original function being advised.
ARGS are the arguments passed to ORIG-FUN.

Delegates to `display-buffer' mechanisms to respect frame raising.
Clears hostile local bindings from rogue packages based on user configuration."
  (let ((display-buffer-overriding-action
         (cond
          ;; User wants to respect overrides, and an override exists
          ((and single-window-respect-display-buffer-overriding-action
                display-buffer-overriding-action)
           display-buffer-overriding-action)
          ;; User wants standard display-buffer-alist to handle it
          (single-window-respect-display-buffer-alist
           nil)
          ;; Strict mode: aggressively force the single window
          (t
           '(display-buffer-same-window
             (inhibit-same-window . nil))))))
    (apply orig-fun args)))

(defconst single-window--display-buffer-entry
  '(single-window--condition-p display-buffer-same-window
                               (inhibit-same-window . nil))
  "Entry added to `display-buffer-alist' when mode is active.")

(defun single-window--condition-p (_buffer-name _action)
  "Condition function for `display-buffer-alist'.
Return non-nil to globally force the buffer to open in the current window.
Allows bypassing the enforcement if `current-prefix-arg' is non-nil
or if a display override is active and permitted by the user."
  (and (not current-prefix-arg)
       (not (and single-window-respect-display-buffer-overriding-action
                 display-buffer-overriding-action))))

;;; Mode

;;;###autoload
(define-minor-mode single-window-mode
  "Toggle `single-window-mode'."
  :global t
  :lighter " single-window"
  :group 'single-window
  (if single-window-mode
      ;; Enable
      (progn
        ;; Save variables only if they have not been saved yet
        (unless single-window--save-vars
          (dolist (var '(org-src-window-setup
                         org-agenda-window-setup
                         org-indirect-buffer-display
                         pop-up-windows
                         pop-up-frames
                         switch-to-buffer-obey-display-actions
                         switch-to-buffer-in-dedicated-window))
            (when (boundp var)
              (push (cons var (symbol-value var)) single-window--save-vars))))

        ;; Allow buffer switching in dedicated windows
        (setq switch-to-buffer-in-dedicated-window t)

        ;; Safely append or prepend to the standard alist based on configuration
        (if single-window-respect-display-buffer-alist
            (add-to-list 'display-buffer-alist single-window--display-buffer-entry t)
          (add-to-list 'display-buffer-alist single-window--display-buffer-entry))

        ;; Defensive safety net against C-level functions splitting frames
        (setq pop-up-windows nil)
        (setq pop-up-frames nil)
        (when (boundp 'switch-to-buffer-obey-display-actions)
          (setq switch-to-buffer-obey-display-actions t))

        ;; Configure org
        (setq org-src-window-setup 'current-window)
        (setq org-agenda-window-setup 'current-window)
        (setq org-indirect-buffer-display 'current-window)

        (advice-add 'pop-to-buffer
                    :around
                    #'single-window--force-single-window-advice)
        (advice-add 'switch-to-buffer-other-window
                    :around
                    #'single-window--force-single-window-advice))
    ;; Disable
    (dolist (var single-window--save-vars)
      (set (car var) (cdr var)))
    (setq single-window--save-vars nil)

    ;; Remove only our specific entry from `display-buffer-alist'
    (setq display-buffer-alist (delete single-window--display-buffer-entry
                                       display-buffer-alist))

    (advice-remove 'pop-to-buffer
                   #'single-window--force-single-window-advice)
    (advice-remove 'switch-to-buffer-other-window
                   #'single-window--force-single-window-advice)))

;;; Provide

(provide 'single-window)

;;; single-window.el ends here

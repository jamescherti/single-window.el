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
  :group 'convenience
  :prefix "single-window-"
  :link '(url-link
          :tag "Github"
          "https://github.com/jamescherti/single-window.el"))

;;; Internal variables

(defvar org-agenda-window-setup)
(defvar org-indirect-buffer-display)
(defvar org-src-window-setup)
(defvar switch-to-buffer-in-dedicated-window)
(defvar switch-to-buffer-obey-display-actions)
(defvar single-window--save-vars nil)

;;; Functions

(defun single-window--force-single-window-advice (orig-fun &rest args)
  "Advice to force functions to open in the current window.
ORIG-FUN is the original function being advised.
ARGS are the arguments passed to ORIG-FUN.

Delegates to `display-buffer' mechanisms to respect frame raising.
Clears hostile local bindings from rogue packages based on user configuration."
  (let ((display-buffer-overriding-action
         (cond
          ;; User explicitly allows overrides, and a valid override exists
          ((and display-buffer-overriding-action
                (car display-buffer-overriding-action))
           display-buffer-overriding-action)
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
Allows bypassing the enforcement if `current-prefix-arg' is non-nil."
  (not current-prefix-arg))

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

        ;; Prepend to the standard alist to ensure precedence
        (add-to-list 'display-buffer-alist single-window--display-buffer-entry)

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

    ;; Remove only our specific entry from `display-buffer-alist' non-destructively
    (setq display-buffer-alist (remove single-window--display-buffer-entry
                                       display-buffer-alist))

    (advice-remove 'pop-to-buffer
                   #'single-window--force-single-window-advice)
    (advice-remove 'switch-to-buffer-other-window
                   #'single-window--force-single-window-advice)))

;;; Provide

(provide 'single-window)

;;; single-window.el ends here

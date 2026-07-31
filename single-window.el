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
  (if current-prefix-arg
      (apply orig-fun args)
    (let ((display-buffer-overriding-action
           '(display-buffer-same-window (inhibit-same-window . nil))))
      ;; Temporarily strip the dedicated status from the selected window so
      ;; `display-buffer-same-window' does not reject it and fall back to
      ;; splitting the frame.
      (with-window-non-dedicated nil
        (apply orig-fun args)))))

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
                         switch-to-buffer-obey-display-actions
                         switch-to-buffer-in-dedicated-window
                         pop-up-windows
                         pop-up-frames))
            (when (boundp var)
              (push (cons var (symbol-value var)) single-window--save-vars))))

        ;; Allow buffer switching in dedicated windows
        (when (boundp 'switch-to-buffer-in-dedicated-window)
          (setq switch-to-buffer-in-dedicated-window t))

        ;; Route buffer switching through display actions
        (when (boundp 'switch-to-buffer-obey-display-actions)
          (setq switch-to-buffer-obey-display-actions t))

        ;; Discourage creating new windows and frames globally
        (setq pop-up-windows nil)
        (setq pop-up-frames nil)

        ;; Configure org
        (setq org-src-window-setup 'current-window)
        (setq org-agenda-window-setup 'current-window)
        (setq org-indirect-buffer-display 'current-window)

        ;; Advise display-buffer to catch all rogue commands
        (advice-add 'display-buffer
                    :around
                    #'single-window--force-single-window-advice))
    ;; Disable
    (dolist (var single-window--save-vars)
      (set (car var) (cdr var)))
    (setq single-window--save-vars nil)

    (advice-remove 'display-buffer
                   #'single-window--force-single-window-advice)))

;;; Provide

(provide 'single-window)

;;; single-window.el ends here

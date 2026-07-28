;;; same-window.el --- Always use the same window -*- lexical-binding: t; -*-

;; Copyright (C) 2026 James Cherti | https://www.jamescherti.com/contact/

;; Author: James Cherti
;; Version: 0.9.9
;; URL: https://github.com/jamescherti/same-window.el
;; Keywords: convenience
;; Package-Requires: ((emacs "24.1"))
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

;; Always use the same window.

;;; Code:

;;; Variables

(defgroup same-window nil
  "Always open buffer in the current window."
  :group 'same-window
  :prefix "same-window-"
  :link '(url-link
          :tag "Github"
          "https://github.com/jamescherti/same-window.el"))

(defcustom same-window-respect-display-buffer-alist t
  "When non-nil, respect user configurations in `display-buffer-alist'.
If enabled, the strict same-window rule is appended as a fallback, allowing
specific buffer rules to take precedence. If nil, the rule is prepended and
aggressively overrides all other configurations."
  :type 'boolean
  :group 'same-window)

(defcustom same-window-verbose nil
  "Enable displaying verbose messages."
  :type 'boolean
  :group 'same-window)

;;; Functions

(defun same-window--message (&rest args)
  "Display a message with the same ARGS arguments as `message'."
  (apply #'message (concat "[same-window] " (car args)) (cdr args)))

(defmacro same-window--verbose-message (&rest args)
  "Display a verbose message with the same ARGS arguments as `message'."
  (declare (indent 0) (debug t))
  `(progn
     (when same-window-verbose
       (same-window--message
        (concat ,(car args)) ,@(cdr args)))))

;;;###autoload
(define-minor-mode same-window-mode
  "Toggle `same-window-mode'."
  :global t
  :lighter " same-window"
  :group 'same-window
  (if same-window-mode
      t
    t))

(provide 'same-window)
;;; same-window.el ends here

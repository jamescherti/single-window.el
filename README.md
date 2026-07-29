# single-window.el - Always open buffers in the current active window
![Build Status](https://github.com/jamescherti/single-window.el/actions/workflows/melpazoid.yml/badge.svg)
![License](https://img.shields.io/github/license/jamescherti/single-window.el)
![](https://jamescherti.com/misc/made-for-gnu-emacs.svg)

The **single-window** package forces Emacs to open buffers in the current active window.

It keeps your carefully arranged layouts intact, reduces visual clutter, and provides a much more predictable workflow. It also handles edge cases by configuring modes like `org-mode` (src blocks and agenda) to respect the current window.

## Installation

### Emacs: use-package and straight (Emacs version < 30)

To install *single-window* with `straight.el`:

1. It if hasn't already been done, [add the straight.el bootstrap code](https://github.com/radian-software/straight.el?tab=readme-ov-file#getting-started) to your init file.
2. Add the following code to the Emacs init file:
```emacs-lisp
(use-package single-window
  :straight (single-window
             :type git
             :host github
             :repo "jamescherti/single-window.el"))
```

### Alternative installation: use-package and :vc (Built-in feature in Emacs version >= 30)

To install *single-window* with `use-package` and `:vc` (Emacs >= 30):

``` emacs-lisp
(use-package single-window
  :vc (:url "https://github.com/jamescherti/single-window.el"
       :rev :newest))
```

### Alternative installation: Doom Emacs

Here is how to install *single-window* on Doom Emacs:

1. Add to the `~/.doom.d/packages.el` file:
```elisp
(package! single-window
  :recipe
  (:host github :repo "jamescherti/single-window.el"))
```

2. Add to `~/.doom.d/config.el`:
```elisp
(after! single-window
  ;; TODO: setq options
  ;; TODO: Load the mode here
  )
```

3. Run the `doom sync` command:
```
doom sync
```

## Customization

You can tweak how aggressively the package enforces its rules using the `single-window-respect-display-buffer-alist` variable:
* `t` (Default): The package appends its strict single-window rule as a fallback. This allows any specific buffer rules you have manually defined in `display-buffer-alist` to take precedence.
* `nil`: The package prepends its rule, aggressively overriding all other window configurations and forcing *everything* into the current window.

## Author and License

The *single-window* Emacs package has been written by [James Cherti](https://www.jamescherti.com/) and is distributed under terms of the GNU General Public License version 3, or, at your choice, any later version.

Copyright (C) 2026 James Cherti

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.

## Links

- [single-window.el @GitHub](https://github.com/jamescherti/single-window.el)

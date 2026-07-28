# same-window.el
![Build Status](https://github.com/jamescherti/same-window.el/actions/workflows/ci.yml/badge.svg)
![License](https://img.shields.io/github/license/jamescherti/same-window.el)
![](https://jamescherti.com/misc/made-for-gnu-emacs.svg)

Always use the same window.

## Installation

### Emacs: use-package and straight (Emacs version < 30)

To install *same-window* with `straight.el`:

1. It if hasn't already been done, [add the straight.el bootstrap code](https://github.com/radian-software/straight.el?tab=readme-ov-file#getting-started) to your init file.
2. Add the following code to the Emacs init file:
```emacs-lisp
(use-package same-window
  :straight (same-window
             :type git
             :host github
             :repo "jamescherti/same-window.el"))
```

### Alternative installation: use-package and :vc (Built-in feature in Emacs version >= 30)

To install *same-window* with `use-package` and `:vc` (Emacs >= 30):

``` emacs-lisp
(use-package same-window
  :vc (:url "https://github.com/jamescherti/same-window.el"
       :rev :newest))
```

### Alternative installation: Doom Emacs

Here is how to install *same-window* on Doom Emacs:

1. Add to the `~/.doom.d/packages.el` file:
```elisp
(package! same-window
  :recipe
  (:host github :repo "jamescherti/same-window.el"))
```

2. Add to `~/.doom.d/config.el`:
```elisp
(after! same-window
  ;; TODO: setq options
  ;; TODO: Load the mode here
  )
```

3. Run the `doom sync` command:
```
doom sync
```

## Author and License

The *same-window* Emacs package has been written by [James Cherti](https://www.jamescherti.com/) and is distributed under terms of the GNU General Public License version 3, or, at your choice, any later version.

Copyright (C) 2026 James Cherti

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.

## Links

- [same-window.el @GitHub](https://github.com/jamescherti/same-window.el)

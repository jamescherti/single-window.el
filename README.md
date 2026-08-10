# single-window.el - Always Open Emacs Buffers in the Current Active Window
![Build Status](https://github.com/jamescherti/single-window.el/actions/workflows/melpazoid.yml/badge.svg)
![License](https://img.shields.io/github/license/jamescherti/single-window.el)
![](https://jamescherti.com/misc/made-for-gnu-emacs.svg)

The **[single-window](https://github.com/jamescherti/single-window.el)** package forces Emacs to open buffers in the current active window.

It keeps your carefully arranged layouts intact, reduces visual clutter, and provides a much more predictable workflow. It handles edge cases by configuring modes like `org-mode` (src blocks and agenda) to respect the current window.

If this project helps your workflow, please consider supporting it by ⭐ starring single-window on GitHub and sharing it on your website, blog, Mastodon, Reddit, X, LinkedIn, or other social media platforms so other Emacs users can discover its benefits.

## Installation and Usage

### Emacs: use-package and straight (Emacs version < 30)

To install *single-window* with `straight.el`:

1. It if hasn't already been done, [add the straight.el bootstrap code](https://github.com/radian-software/straight.el?tab=readme-ov-file#getting-started) to your init file.
2. Add the following code to the Emacs init file:
```emacs-lisp
(use-package single-window
  :straight (single-window
             :type git
             :host github
             :repo "jamescherti/single-window.el")
  :config
  (single-window-mode 1))
```

### Alternative installation: use-package and :vc (Built-in feature in Emacs version >= 30)

To install *single-window* with `use-package` and `:vc` (Emacs >= 30):

```emacs-lisp
(use-package single-window
  :vc (:url "https://github.com/jamescherti/single-window.el"
       :rev :newest)
  :config
  (single-window-mode 1))
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
  (single-window-mode 1))
```

3. Run the `doom sync` command:

```
doom sync
```

## Author and License

The *single-window* Emacs package has been written by [James Cherti](https://www.jamescherti.com/) and is distributed under terms of the GNU General Public License version 3, or, at your choice, any later version.

Copyright (C) 2026 James Cherti

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.

## See also

- [popper](https://github.com/karthink/popper)
- [auto-side-windows](https://github.com/MArpogaus/auto-side-windows)
- [current-window-only](https://github.com/FrostyX/current-window-only)
- [popwin](https://github.com/emacsorphanage/popwin)

## Links

- [single-window.el @GitHub](https://github.com/jamescherti/single-window.el)

Other Emacs packages by the same author:
- [compile-angel.el](https://github.com/jamescherti/compile-angel.el): **Speed up Emacs!** This package guarantees that all .el files are both byte-compiled and native-compiled, which significantly speeds up Emacs.
- [outline-indent.el](https://github.com/jamescherti/outline-indent.el): An Emacs package that provides a minor mode that enables code folding and outlining based on indentation levels for various indentation-based text files, such as YAML, Python, and other indented text files.
- [easysession.el](https://github.com/jamescherti/easysession.el): Easysession is lightweight Emacs session manager that can persist and restore file editing buffers, indirect buffers/clones, Dired buffers, the tab-bar, and the Emacs frames (with or without the Emacs frames size, width, and height).
- [vim-tab-bar.el](https://github.com/jamescherti/vim-tab-bar.el): Make the Emacs tab-bar Look Like Vim's Tab Bar.
- [elispcomp](https://github.com/jamescherti/elispcomp): A command line tool that allows compiling Elisp code directly from the terminal or from a shell script. It facilitates the generation of optimized .elc (byte-compiled) and .eln (native-compiled) files.
- [tomorrow-night-deepblue-theme.el](https://github.com/jamescherti/tomorrow-night-deepblue-theme.el): The Tomorrow Night Deepblue Emacs theme is a beautiful deep blue variant of the Tomorrow Night theme, which is renowned for its elegant color palette that is pleasing to the eyes. It features a deep blue background color that creates a calming atmosphere. The theme is also a great choice for those who miss the blue themes that were trendy a few years ago.
- [Ultyas](https://github.com/jamescherti/ultyas/): A command-line tool designed to simplify the process of converting code snippets from UltiSnips to YASnippet format.
- [dir-config.el](https://github.com/jamescherti/dir-config.el): Automatically find and evaluate .dir-config.el Elisp files to configure directory-specific settings.
- [flymake-bashate.el](https://github.com/jamescherti/flymake-bashate.el): A package that provides a Flymake backend for the bashate Bash script style checker.
- [flymake-ansible-lint.el](https://github.com/jamescherti/flymake-ansible-lint.el): An Emacs package that offers a Flymake backend for ansible-lint.
- [inhibit-mouse.el](https://github.com/jamescherti/inhibit-mouse.el): A package that disables mouse input in Emacs, offering a simpler and faster alternative to the disable-mouse package.
- [quick-sdcv.el](https://github.com/jamescherti/quick-sdcv.el): This package enables Emacs to function as an offline dictionary by using the sdcv command-line tool directly within Emacs.
- [enhanced-evil-paredit.el](https://github.com/jamescherti/enhanced-evil-paredit.el): An Emacs package that prevents parenthesis imbalance when using *evil-mode* with *paredit*. It intercepts *evil-mode* commands such as delete, change, and paste, blocking their execution if they would break the parenthetical structure.
- [stripspace.el](https://github.com/jamescherti/stripspace.el): Ensure Emacs Automatically removes trailing whitespace before saving a buffer, with an option to preserve the cursor column.
- [persist-text-scale.el](https://github.com/jamescherti/persist-text-scale.el): Ensure that all adjustments made with text-scale-increase and text-scale-decrease are persisted and restored across sessions.
- [pathaction.el](https://github.com/jamescherti/pathaction.el): Execute the pathaction command-line tool from Emacs. The pathaction command-line tool enables the execution of specific commands on targeted files or directories. Its key advantage lies in its flexibility, allowing users to handle various types of files simply by passing the file or directory as an argument to the pathaction tool. The tool uses a .pathaction.yaml rule-set file to determine which command to execute. Additionally, Jinja2 templating can be employed in the rule-set file to further customize the commands.
- [kirigami.el](https://github.com/jamescherti/kirigami.el): The *kirigami* Emacs package offers a unified interface for opening and closing folds across a diverse set of major and minor modes in Emacs, including `outline-mode`, `outline-minor-mode`, `outline-indent-minor-mode`, `org-mode`, `markdown-mode`, `vdiff-mode`, `vdiff-3way-mode`, `hs-minor-mode`, `hide-ifdef-mode`, `origami-mode`, `yafolding-mode`, `folding-mode`, and `treesit-fold-mode`. With Kirigami, folding key bindings only need to be configured **once**. After that, the same keys work consistently across all supported major and minor modes, providing a unified and predictable folding experience.
- [buffer-guardian.el](https://github.com/jamescherti/buffer-guardian.el): Automatically saves Emacs buffers without requiring manual intervention. By default, it triggers a save when the user switches to another buffer, switches to another window or frame, Emacs loses focus, or the minibuffer is opened. Beyond standard file buffers, *buffer-guardian* also manages specialized editing buffers such as *org-src* and *edit-indirect*. Additional features, disabled by default, include periodic or idle-time saving of all buffers, automatic exclusion of remote, nonexistent, or large files, and support for custom exclusion rules via regular expressions or predicate functions.

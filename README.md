# single-window.el - Always Open Emacs Buffers in the Current Active Window
![Build Status](https://github.com/jamescherti/single-window.el/actions/workflows/melpazoid.yml/badge.svg)
![License](https://img.shields.io/github/license/jamescherti/single-window.el)
![](https://jamescherti.com/misc/made-for-gnu-emacs.svg)

The **[single-window](https://github.com/jamescherti/single-window.el)** package forces Emacs to open buffers in the current active window.

It keeps your carefully arranged layouts intact, reduces visual clutter, and provides a much more predictable workflow.

To ensure it does not break standard Emacs functionality, the package is built to handle the following edge cases and integrations out of the box:

- **Transient and Magit:** Excludes Transient buffers by default, which ensures that Magit popup menus render correctly and manage their own window placement.
- **Ediff control panel:** Excludes the Ediff control interface so it can maintain its specific layout requirements without breaking.
- **Temporary and utility buffers:** Ignores the minibuffer, asynchronous Emacs warnings, Org capture popups, and built-in `*Completions*` buffers so they do not hijack your active workspace.
- **Dedicated windows:** Safely handles dedicated windows in the background (e.g., `grep-mode` or `embark-export`), temporarily un-dedicating them to load the buffer without throwing errors or breaking the layout.
- **Org-mode integrations:** Configures Org-mode to open source blocks, the agenda, and indirect buffers directly in the active window
- **Manual overrides:** Allows you to temporarily bypass the single-window enforcement by passing a prefix argument (e.g., `C-u`) before running a command.

The package also provides the following customization options:

- **Custom window rules:** Provides a setting (`single-window-respect-display-buffer-alist`) that lets you prioritize your own custom display rules for specific buffers, while falling back to the single-window behavior for everything else.
- **Customizable exclusions:** Allows you to define additional exclusions via the `single-window-exclude-regexps` variable, which accepts a list of regular expressions to match ignored buffer names.
- **Popper integration:** Provides `single-window-exclude-popper` (disabled by default) to allow **popper** to bypass the **single-window** package enforcement for its popups.

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

## Frequently Asked Questions

### What does this provide over `display-buffer-alist`?

The **single-window** package provides a minor mode that handles edge cases.

While similar behavior can be replicated by adding a catch-all rule to `display-buffer-alist`, this often disrupts standard Emacs functionality.

For instance, forcing all buffers into the active window via `display-buffer-alist` interferes with packages that rely on specific user interface layouts, such as Ediff, Transient (which includes Magit), Org Agenda, and many others. This package resolves this by providing default configurations that natively exclude these specific edge cases.

Additionally, the package manages dedicated windows. For example, if a user attempts to open a file directly from a dedicated `grep-mode` or `embark-export` search results buffer, standard display rules will often cause Emacs to split the frame. The **single-window** package intercepts this action, temporarily removes the dedicated flag so the buffer can load in the active window, and then restores the original state.

It also includes a fallback mechanism. If Emacs is forbidden from using the current window (e.g., you invoke a command while inside the minibuffer), Emacs usually splits the frame. This package catches that edge case and safely uses another existing window instead.

Finally, the package allows bypassing the strict window enforcement for individual commands by supplying a prefix argument (`C-u`).

### What is the difference with popper?

The **single-window** and **popper** packages are not mutually exclusive and can be used simultaneously.

The **popper** package displays temporary buffers in a dedicated popup area, typically at the bottom of the screen, which allows for quick dismissal.

In contrast, **single-window** prevents automated window splitting. It also provides a mechanism for exceptions, allowing specific packages, such as Transient, and popper itself, to bypass the strict single-window enforcement and split the frame as originally intended.

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

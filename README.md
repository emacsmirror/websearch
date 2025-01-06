# Emacs-WebSearch

<p align="center">
  <a href="https://melpa.org/#/websearch">
    <img src="https://melpa.org/packages/websearch-badge.svg">
  </a>
  <a href="https://stable.melpa.org/#/websearch">
    <img src="https://stable.melpa.org/packages/websearch-badge.svg">
  </a>
</p>

Query search engines from Emacs.

<p align="center">
  <img src="logo.png" width="250" height="250">
</p>

## About

The websearch package allows You to query predefined search engines
(`websearch-custom-engines`) with interactive selection.
The query terms can either be extracted form selection, kill-ring
or typed on demand.

The `websearch` function is a interactive entry-point to select both
the terms extraction method and search engine provider.

To turn on the global mode enabling a custom key map,
activate `websearch-mode`.

`websearch` is inspired by `engine-mode`
(https://github.com/hrs/engine-mode), but the differences are big enough
for it to be it's own package.

The `websearch-define` macro helps you to create function to call
`websearch` with a specific engine or tag found in
(`websearch-custom-engines`).

For example if I want to just search github

```emacs-lisp
(websearch-define "github")
```

That will define the interactive function

```emacs-lisp
(lambda (search-term &optional arg)
  "Search Github for SEARCH-TERM with `websearch'.
SEARCH-TERM is region if region is selected
When called with prefix ARG use `kill-ring' for completions"
  (interactive
   (let* ((arg current-prefix-arg)
          (region (if (use-region-p)
                      (buffer-substring-no-properties
                       (region-beginning)
                       (region-end))))
          (kill (mapcar #'substring-no-properties kill-ring))
          (thing-at-point (if (thing-at-point 'symbol)
                              (progn (substring-no-properties
                                      (thing-at-point 'symbol)))))
          (completions (if arg
                           kill
                         (remove nil (delete-dups
                                      (list region thing-at-point kill))))))
     (list (completing-read "Search term: " completions))))
  (websearch--browse-url search-term "github"))
```

When executed it will search github for the region or if no region is
selected promt for input with completion for your last kill,
thing-at-point or custom input.

The macro can also take additional arguments, if called with the
query-separator and query-url argument it will add the engine to
(`websearch-custom-engines`) with the tag "generic" or the tag can be
changed using the tags argument. Here is an example

```emacs-lisp
(websearch-define "brave"
    :query-separator "+"
    :query-url "search.brave.com/search?q="
    :tags ("text" "generic"))
```

If you also want to bind it to a key you can call it with the
keybinding argument like so.

```emacs-lisp
(websearch-define "emacswiki"
    :query-separator "+"
    :query-url "duckduckgo.com/?q=site%3Aemacswiki.org+"
    :tags ("text" "emacs")
    :keybinding "e") ;; Becomes "C-c C-s e"
```

The keybinding is applied to the `websearch-mode-map` and defaults to using the
`websearch-custom-keymap-prefix` (default "C-c C-s").

You can also define a search of the engines by tag e.g. #code-forge

```emacs-lisp
(websearch-define "#code-forge")

;; or with keybinding
(websearch-define "#code-forge"
    :keybinding "C")
```

Instead of one website a websearch group found in
(`websearch-custom-groups') can also be searched like so

```emacs-lisp
(websearch-define-group "google, duckduckgo, yandex"
    :keybinding "d")
```
It can also be used to add an engine to (`websearch-custom-engines')
or an engine-group to (`websearch-custom-groups') without creating a function

```emacs-lisp
(websearch-define "yahoo"
    :query-separator "+"
    :query-url "search.yahoo.com/search?p="
    :tags ("text" "generic")
    :keybinding "y"  ;; no effect due to :function nil argument
    :function nil)
;; => ("yahoo" "+" "search.yahoo.com/search?p=" ("text" "generic"))
;; added to `websearch-custom-engines'
;; Keybinding "y" not created as there will be no function to call
;; alternativly
(websearch-define "yahoo"
    :query-separator "+"
    :query-url "search.yahoo.com/search?p="
    :tags ("text" "generic")
    :function nil)

;; or as a group
(websearch-define-group "google, yahoo, brave, duckduckgo, yandex"
    :keybinding "A"  ;; no effect due to :function nil argument
    :function nil)
;; => "google, yahoo, brave, duckduckgo, yandex" added to
;; `websearch-custom-groups'
```

## License

SPDX-License-Identifier: GPL-2.0-or-later

    This file is part of xgqt-elisp-lib-websearch - query search engines from Emacs.
    Copyright (c) 2022-2015, Maciej Barć <xgqt@xgqt.org>
    Licensed under the GNU GPL v2 License

    xgqt-elisp-lib-websearch is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    xgqt-elisp-lib-websearch is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with xgqt-elisp-lib-websearch.  If not, see <https://www.gnu.org/licenses/>.

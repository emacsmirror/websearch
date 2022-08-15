;;; websearch-custom.el --- Customization for websearch -*- lexical-binding: t -*-


;; This file is part of emacs-websearch.

;; emacs-websearch is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, version 3.

;; emacs-websearch is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with emacs-websearch.  If not, see <https://www.gnu.org/licenses/>.

;; Copyright (c) 2022, Maciej Barć <xgqt@riseup.net>
;; Licensed under the GNU GPL v3 License



;;; Commentary:


;; Customization for ‘websearch’.



;;; Code:


(defcustom websearch-custom-engines
  '(("britannica"       ?\s "www.britannica.com/search?query=")
    ("c++-docs"         ?+  "cplusplus.com/search.do?q=")
    ("codeberg"         ?+  "codeberg.org/explore/repos?q=")
    ("dailymotion"      ?\s "https://www.dailymotion.com/search/")    
    ("die"              ?+  "www.die.net/search/?q=")
    ("django-docs"      ?+  "docs.djangoproject.com/en/4.0/search/?q=")
    ("duckduckgo"       ?+  "duckduckgo.com/?q=")
    ("gentoo-bugs"      ?+  "bugs.gentoo.org/buglist.cgi?quicksearch=")
    ("gentoo-overlays"  ?+  "gpo.zugaina.org/Search?search=")
    ("gentoo-packages"  ?+  "packages.gentoo.org/packages/search?q=")
    ("gentoo-wiki"      ?+  "wiki.gentoo.org/index.php?search=")
    ("github"           ?+  "github.com/search?q=")
    ("gitlab"           ?+  "gitlab.com/search?search=")
    ("google"           ?+  "google.com/search?q=")
    ("google-maps"      ?+  "maps.google.com/maps?q=")
    ("julia-docs"       ?+  "docs.julialang.org/en/v1/search/?q=")
    ("julia-packages"   ?+  "juliapackages.com/packages?search=")
    ("melpa"            ?+  "melpa.org/#/?q=")
    ("melpa-stable"     ?+  "stable.melpa.org/#/?q=")
    ("movie-archive"    ?+  "https://archive.org/details/movies?query=")
    ("odysee"           ?+  "odysee.com/$/search?q=")
    ("peertube"         ?+  "search.joinpeertube.org/search?search=")
    ("python-docs"      ?+  "docs.python.org/3/search.html?q=")
    ("python-packages"  ?+  "pypi.org/search/?q=")
    ("qwant"            ?+  "qwant.com/?q=")
    ("sjp"              ?\s "sjp.pwn.pl/slowniki/")  ; Polish dictionary
    ("racket-docs"      ?\s "docs.racket-lang.org/search/index.html?q=")
    ("racket-packages"  ?+  "pkgd.racket-lang.org/pkgn/search?q=")
    ("reddit"           ?+  "reddit.com/search/?q=")
    ("repology"         ?-  "repology.org/projects/?search=")
    ("rust-packages"    ?+  "crates.io/search?q=")
    ("softwareheritage" ?+  "archive.softwareheritage.org/browse/search/?q=")
    ("stackoverflow"    ?+  "stackoverflow.com/search?q=")
    ("tiktok"           ?/s "https://www.tiktok.com/search?q=")
    ("twitter"          ?+  "twitter.com/search?q=")
    ("unicode-table"    ?+  "unicode-table.com/en/search/?q=")
    ("urbandictionary"  ?+  "urbandictionary.com/define.php?term=")
    ("wikipedia-en"     ?_  "en.wikipedia.org/wiki/")
    ("wikipedia-pl"     ?_  "pl.wikipedia.org/wiki/")
    ("wolframalpha"     ?+  "wolframalpha.com/input/?i=")
    ("yandex"           ?+  "yandex.com/search/?text=")
    ("yewtube"          ?+  "yewtu.be/search?q=")  ; just a Invidious instance ;-)
    ("youtube"          ?+  "youtube.com/results?search_query="))
  "List of supported search engines.

Each element in this list is a list of three elements:
- name of the search engine, string,
  for example: \"duckduckgo\" or \"wikipedia-en\",
- separator used for queries, character,
  for example: ?+, ?_ or ?\s (space character),
- query URL (without \"https://\" prefix), string,
  for example: \"duckduckgo.com/?q=\" or \"en.wikipedia.org/wiki/\"."
  :type '(repeat (list string character string))
  :group 'websearch)

(defcustom websearch-custom-groups
  '("google, duckduckgo, yandex"
    "codeberg, github, gitlab, repology, softwareheritage")
  "List of search engines to search at once.

The engines are split by the \",\" (comma) separator.

For example: \"google, duckduckgo, yandex\" means:
search google, duckduckgo and yandex a the same time.

This variable is used in the `websearch--select-engines'."
  :type '(repeat string)
  :group 'websearch)

(defcustom websearch-custom-default-engine nil
  "Default search engine.

This is the default input for `completing-read' when prompted
to select an engine.
Can be set to any name of a search engine from ‘websearch-custom-engines’."
  :type 'string
  :group 'websearch)

(defcustom websearch-custom-browse-url-function 'browse-url-default-browser
  "Function to browse a full query URL with."
  :type 'symbol
  :group 'websearch)

(defcustom websearch-custom-browse-url-function-candidates
  '(eww
    browse-url-default-browser
    browse-url-generic
    browse-url-firefox
    browse-url-chromium
    browse-url-chrome)
  "Candidates to browse a full query URL with."
  :type '(repeat symbol)
  :group 'websearch)

(defcustom websearch-custom-keymap-prefix "C-c C-s"
  "Keymap prefix for ‘websearch-mode’."
  :type 'string
  :group 'websearch)


(provide 'websearch-custom)



;;; websearch-custom.el ends here

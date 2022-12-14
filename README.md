# Emacs-WebSearch

<p align="center">
    <a href="https://melpa.org/#/websearch">
        <img src="https://melpa.org/packages/websearch-badge.svg">
    </a>
    <a href="https://stable.melpa.org/#/websearch">
        <img src="https://stable.melpa.org/packages/websearch-badge.svg">
    </a>
    <a href="https://archive.softwareheritage.org/browse/origin/?origin_url=https://gitlab.com/xgqt/emacs-websearch">
        <img src="https://archive.softwareheritage.org/badge/origin/https://gitlab.com/xgqt/emacs-websearch/">
    </a>
    <a href="https://gitlab.com/xgqt/emacs-websearch/pipelines">
        <img src="https://gitlab.com/xgqt/emacs-websearch/badges/master/pipeline.svg">
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


## License

Copyright (c) 2022, Maciej Barć <xgqt@riseup.net>

Licensed under the GNU GPL v2 License

SPDX-License-Identifier: GPL-2.0-or-later

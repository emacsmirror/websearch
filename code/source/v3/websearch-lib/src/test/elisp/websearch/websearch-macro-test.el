;;; websearch-macro-test.el --- Macro tests for websearch  -*- lexical-binding: t; -*-

;; This file is part of xgqt-elisp-lib-websearch - query search engines from Emacs.
;; Copyright (c) 2022-2025, Maciej Barć <xgqt@xgqt.org>
;; Licensed under the GNU GPL v2 License
;;
;; xgqt-elisp-lib-websearch is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 2 of the License, or
;; (at your option) any later version.
;;
;; xgqt-elisp-lib-websearch is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with xgqt-elisp-lib-websearch.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Tests for `websearch-define' and `websearch-define-group'.

;;; Code:

(require 'ert nil t)
(require 'websearch nil t)
(require 'websearch-custom nil t)
(require 'websearch-mode nil t)

(unless noninteractive
  (defvar websearch-macro-tests-custom-engines-backup websearch-custom-engines
    "Backup variable to restore `websearch-custom-engines' after tests.")

  (defvar websearch-macro-tests-custom-groups-backup websearch-custom-groups
    "Backup variable to restore `websearch-custom-groups' after tests.")

  (defvar websearch-macro-tests-mode-backup websearch-mode
    "Backup variable to restore status of `websearch-mode' after tests.")

  (defvar websearch-macro-tests-non-bound-functions nil
    "Backup list of function to unbind after tests.")

  (defvar websearch-macro-tests-functions
    '(websearch-brave
      websearch-emacs-stackexchange
      websearch-emacswiki
      websearch-google
      websearch-youtube
      websearch-group-google-reddit-youtube
      websearch-group-youtube-odysee-peertube-dailymotion-yewtube
      websearch-group-wolframalpha-wikipedia-en-anarchistlibrary
      websearch-group-codeberg-github-gitlab-repology-softwareheritage
      websearch-group-google-duckduckgo-yandex
      websearch-group-melpa-melpa-stable-repology))

  (defun websearch-macro-tests-function-bound-p (function)
    "If FUNCTION bound add to `websearch-macro-tests-non-bound-functions'."
    (unless (functionp function)
      (push function websearch-macro-tests-non-bound-functions)))

  (mapcar #'websearch-macro-tests-function-bound-p
          websearch-macro-tests-functions))

(websearch-mode 1)

(ert-deftest websearch-macro-engine-add-test ()
  "Assert that engines are added to `websearch-custom-engines'."
  (websearch-define "brave"
      :query-url "search.brave.com/search?q="
      :query-separator ?+
      :tags ("text" "generic")
      :function nil)
  (websearch-define "emacs-stackexchange"
      :query-url "emacs.stackexchange.com/search?q="
      :query-separator ?+
      :tags ("text" "generic")
      :function nil)
  (websearch-define "emacswiki"
      :query-url "search.brave.com/search?q=site%3Aemacswiki.org+"
      :query-separator ?+
      :tags ("text" "generic")
      :function nil)
  (should (assoc "brave" websearch-custom-engines))
  (should (assoc "emacs-stackexchange" websearch-custom-engines))
  (should (assoc "emacswiki" websearch-custom-engines)))

(ert-deftest websearch-macro-group-add-test ()
  "Assert that groups are added to `websearch-custom-groups'."
  (websearch-define-group "google, reddit, youtube"
      :function nil)
  (websearch-define-group "youtube, odysee, peertube, dailymotion, yewtube"
      :function nil)
  (websearch-define-group "wolframalpha, wikipedia-en, anarchistlibrary"
      :function nil)
  (should (member "google, reddit, youtube" websearch-custom-groups))
  (should (member "youtube, odysee, peertube, dailymotion, yewtube" websearch-custom-groups))
  (should (member "wolframalpha, wikipedia-en, anarchistlibrary" websearch-custom-groups)))

(ert-deftest websearch-macro-engine-function-p-test ()
  (websearch-define "brave")
  (websearch-define "emacs-stackexchange")
  (websearch-define "emacswiki")
  (websearch-define "google")
  (websearch-define "youtube")
  (should (functionp 'websearch-brave))
  (should (functionp 'websearch-emacs-stackexchange))
  (should (functionp 'websearch-emacswiki))
  (should (functionp 'websearch-google))
  (should (functionp 'websearch-youtube)))

(ert-deftest websearch-macro-group-function-p-test ()
  (websearch-define-group "google, reddit, youtube")
  (websearch-define-group "youtube, odysee, peertube, dailymotion, yewtube")
  (websearch-define-group "wolframalpha, wikipedia-en, anarchistlibrary")
  (websearch-define-group "codeberg, github, gitlab, repology, softwareheritage")
  (websearch-define-group "google, duckduckgo, yandex")
  (websearch-define-group "melpa, melpa-stable, repology")
  (should (functionp 'websearch-group-google-reddit-youtube))
  (should (functionp 'websearch-group-youtube-odysee-peertube-dailymotion-yewtube))
  (should (functionp 'websearch-group-wolframalpha-wikipedia-en-anarchistlibrary))
  (should (functionp 'websearch-group-codeberg-github-gitlab-repology-softwareheritage))
  (should (functionp 'websearch-group-google-duckduckgo-yandex))
  (should (functionp 'websearch-group-melpa-melpa-stable-repology)))

(unless noninteractive
  (mapc #'fmakunbound websearch-macro-tests-non-bound-functions)
  (unless websearch-macro-tests-mode-backup
    (websearch-mode -1)))

(provide 'websearch-macro-test)

;;; websearch-macro-test.el ends here

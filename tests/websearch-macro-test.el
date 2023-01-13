;;; websearch-macro-test.el --- Macro tests for websearch  -*- lexical-binding: t; -*-


;; This file is part of websearch - query search engines from Emacs.
;; Copyright (c) 2022-2023, Maciej Barć <xgqt@riseup.net>
;; Licensed under the GNU GPL v2 License
;; SPDX-License-Identifier: GPL-2.0-or-later

;; websearch is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 2 of the License, or
;; (at your option) any later version.

;; websearch is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with websearch.  If not, see <https://www.gnu.org/licenses/>.



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

  (defvar websearch-macro-tests-functions '(websearch-brave
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

  (mapcar #'websearch-macro-tests-function-bound-p websearch-macro-tests-functions))


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

(ert-deftest websearch-macro-engine-keybound-p-test ()
  (websearch-define "brave"
                    :keybinding "~ b")
  (websearch-define "emacs-stackexchange"
                    :keybinding "~ E")
  (websearch-define "emacswiki"
                    :keybinding "~ e")
  (websearch-define "google"
                    :keybinding "~ g")
  (websearch-define "youtube"
                    :keybinding "~ y")
  (websearch-define "codeberg"
                    :keybinding "~ c")
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "~ b"))) 'websearch-brave))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "~ E"))) 'websearch-emacs-stackexchange))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "~ e"))) 'websearch-emacswiki))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "~ g"))) 'websearch-google))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "~ y"))) 'websearch-youtube))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "~ c"))) 'websearch-codeberg)))

(ert-deftest websearch-macro-group-keybound-p-test ()
  (websearch-define-group "google, reddit, youtube"
                          :keybinding "! g")
  (websearch-define-group "youtube, odysee, peertube, dailymotion, yewtube"
                          :keybinding "! y")
  (websearch-define-group "wolframalpha, wikipedia-en, anarchistlibrary"
                          :keybinding "! w")
  (websearch-define-group "codeberg, github, gitlab, repology, softwareheritage"
                          :keybinding "! c")
  (websearch-define-group "google, duckduckgo, yandex"
                          :keybinding "! s")
  (websearch-define-group "melpa, melpa-stable, repology"
                          :keybinding "! m")
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "! g"))) 'websearch-group-google-reddit-youtube))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "! y"))) 'websearch-group-youtube-odysee-peertube-dailymotion-yewtube))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "! w"))) 'websearch-group-wolframalpha-wikipedia-en-anarchistlibrary))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "! c"))) 'websearch-group-codeberg-github-gitlab-repology-softwareheritage))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "! s"))) 'websearch-group-google-duckduckgo-yandex))
  (should (eq (key-binding (kbd (format "%s %s " websearch-custom-keymap-prefix "! m"))) 'websearch-group-melpa-melpa-stable-repology)))


(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "~ b")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "~ E")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "~ e")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "~ g")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "~ y")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "~ c")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "! g")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "! y")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "! w")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "! c")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "! s")) nil)
(define-key websearch-mode-map (kbd (format "%s %s " websearch-custom-keymap-prefix "! m")) nil)


(unless noninteractive
  (mapc #'fmakunbound websearch-macro-tests-non-bound-functions)
  (unless websearch-macro-tests-mode-backup
    (websearch-mode -1)))


(provide 'websearch-macro-test)



;;; websearch-macro-test.el ends here

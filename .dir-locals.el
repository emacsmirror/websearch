;; -*- no-byte-compile: t -*-

;; Directory Local Variables
;; For more information see (info "(emacs) Directory Variables")
;; Documentation: https://www.gnu.org/software/emacs/manual/html_node/emacs/Directory-Variables.html

((find-file             . ((require-final-newline . t)
                           (show-trailing-whitespace . t)))
 (bazel-mode            . ((eval . (progn
                                     (add-hook 'before-save-hook #'whitespace-cleanup nil t)
                                     (add-hook 'before-save-hook #'bazel-buildifier nil t)))
                           (indent-tabs-mode . nil)))
 (nix-mode              . ((eval . (progn
                                     (add-hook 'before-save-hook #'whitespace-cleanup nil t)
                                     (add-hook 'before-save-hook #'nix-format-buffer nil t)))
                           (indent-tabs-mode . nil) (tab-width . 2)))
 (html-mode             . ((indent-tabs-mode . nil) (tab-width . 2)))
 (js-json-mode          . ((indent-tabs-mode . nil) (tab-width . 2)))
 (makefile-mode         . ((indent-tabs-mode . t)   (tab-width . 4)))
 (nxml-mode             . ((indent-tabs-mode . nil) (tab-width . 2)))
 (python-mode           . ((indent-tabs-mode . nil) (tab-width . 4)))
 (xml-mode              . ((indent-tabs-mode . nil) (tab-width . 2)))
 (yaml-mode             . ((indent-tabs-mode . nil) (tab-width . 2))))

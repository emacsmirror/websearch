# Copyright (c) 2022-2025, Maciej Barć <xgqt@xgqt.org>

{ pkgs ? import <nixpkgs> { } }:

let shellName = "websearch_v3";
in pkgs.mkShell {
  name = shellName;

  buildInputs = with pkgs; [
    emacs

    git
    glibc
    glibcLocales
    gnumake
    gnutar
  ];

  shellHook = ''
    export PS1="${shellName}> "
  '';
}

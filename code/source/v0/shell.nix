{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    bash
    gnumake

    # Dev packages
    commitizen
    pre-commit

    # Fundamental packages
    git
    glibcLocales
  ];
}

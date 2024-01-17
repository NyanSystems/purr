let
  # Fetch the nixpkgs-unstable channel
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
  };
  pkgs = import nixpkgs {};

in
pkgs.mkShell rec {
  name = "purr";

  packages = with pkgs; [
    zola
  ];

  # Terminaldagi muhitni ishlash uchun kerakli qismlar sozlash.
  shellHook = let
    icon = "f121";
  in ''
    export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
  '';
}
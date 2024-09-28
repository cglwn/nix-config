{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.zsh
    pkgs.oh-my-zsh
    pkgs.ripgrep
    pkgs.fzf
  ];

  shellHook = ''
    export SHELL=$(which zsh)
    if [ -z "$ZSH" ]; then
      echo "Setting up oh-my-zsh"
      sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
  '';
}

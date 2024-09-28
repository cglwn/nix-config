{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.ripgrep
    pkgs.fzf
  ];

  shellHook = ''
  # Set up fzf key bindings and completion
  source ${pkgs.fzf}/share/fzf/key-bindings.bash
  source ${pkgs.fzf}/share/fzf/completion.bash

  # Configure fzf for history search
  export FZF_CTRL_R_OPTS="--sort --exact"

  # Optional: Customize fzf command to use ripgrep
  export FZF_DEFAULT_COMMAND='rg --files --hidden'

  # Optional: Set a custom prompt to indicate you're in a Nix shell
  export PS1="\n\[\033[1;32m\][nix-shell:\w]\$\[\033[0m\] "
  '';
}

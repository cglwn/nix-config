{ pkgs ? import <nixpkgs> {} }:

let
  myEmacsConfig = pkgs.writeText "my-emacs-config.el" ''
    (custom-set-variables
     '(xterm-mouse-mode t))
  '';
in
pkgs.mkShell {
  buildInputs = [
    pkgs.ripgrep
    pkgs.fzf
    pkgs.emacs
    pkgs.git
  ];

  shellHook = ''
  # Set up fzf key bindings and completion
  source ${pkgs.fzf}/share/fzf/key-bindings.bash
  source ${pkgs.fzf}/share/fzf/completion.bash

  # Configure fzf for history search
  export FZF_CTRL_R_OPTS="--sort --exact"

  # Optional: Customize fzf command to use ripgrep
  export FZF_DEFAULT_COMMAND='rg --files --hidden'

  # Set up Emacs with custom configuration
  export EMACSLOADPATH="${pkgs.emacs}/share/emacs/site-lisp:"
  alias emacs='emacs -q --load ${myEmacsConfig}'

  # Optional: Set a custom prompt to indicate you're in a Nix shell
  export PS1="\n\[\033[1;32m\][nix-shell:\w]\$\[\033[0m\] "
  '';
}

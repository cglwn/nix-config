My Nix configuration that I use for a development environment on Linux.

# Installation
I primarily use Ubuntu 24.04 so these instructions are for that and will need to be adapted for other distros.

For the Nix installation to succeed, install dependencies
```sh
sudo apt update
sudo apt install xz-utils
```

Install Nix
```sh
curl -L https://nixos.org/nix/install | sh
```

After the installation is complete, enable Nix in your current shell session
```sh
source ~/.nix-profile/etc/profile.d/nix.sh
```

# Usage
To start the environment, run
```sh
nix-shell
```


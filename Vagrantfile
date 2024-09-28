Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"  # Ubuntu 22.04 LTS (Jammy Jellyfish)
  config.vm.box_version = "20240131.0.0"  # Use the latest version available as of now

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "2"
  end

  config.vm.provision "shell", inline: <<-SHELL
    # Update and install dependencies
    sudo apt-get update
    sudo apt-get install -y xz-utils curl

    # Install Nix
    curl -L https://nixos.org/nix/install | sh -s -- --daemon

    # Create Nix configuration directory
    mkdir -p /home/vagrant/nix-config

    # Create default.nix file
    cat << EOF > /home/vagrant/nix-config/default.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.zsh
    pkgs.oh-my-zsh
    pkgs.ripgrep
    pkgs.fzf
  ];

  shellHook = ''
    export SHELL=\$(which zsh)
    if [ -z "\$ZSH" ]; then
      echo "Setting up oh-my-zsh"
      sh -c "\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
  '';
}
EOF

    # Set up Nix environment for the vagrant user
    echo '. /home/vagrant/.nix-profile/etc/profile.d/nix.sh' >> /home/vagrant/.bashrc

    # Change ownership of the nix-config directory to vagrant user
    chown -R vagrant:vagrant /home/vagrant/nix-config

    echo "Nix configuration set up complete. You can now use 'nix-shell' in the /home/vagrant/nix-config directory."
  SHELL
end

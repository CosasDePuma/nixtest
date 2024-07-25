{ config, ... }: {
  imports = [
    ./gc.nix
    ./grub.nix
    ./internationalisation.nix
    ./networking.nix
    ./nh.nix
    ./nix.nix
    ./sound.nix
  ];
}
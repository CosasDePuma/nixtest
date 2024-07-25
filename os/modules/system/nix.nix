{ lib, system ? "x86_64-linux", ... }: {
  # NixOS
  system.stateVersion = lib.mkDefault "unstable";

  # Nixpkgs
  nixpkgs.config.allowUnfree = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "${system}";

  # Nix
  nix.enable = lib.mkDefault true;
  nix.channel.enable = lib.mkDefault true;
  nix.settings.allowed-users = lib.mkDefault [ "root" "@wheel" ];
  nix.settings.trusted-users = lib.mkDefault [ "root" "@wheel" ];
  nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];
}
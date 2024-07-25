{ username ? "user", ... }: { config, lib, ... }: {
  # Disable default garbage collector
  nix.gc.automatic = lib.mkForce false;
  
  # NH
  programs.nh.enable = lib.mkDefault true;
  programs.nh.flake = lib.mkDefault "/home/${username}/.config/nixos";

  # NH: Garbage collector
  programs.nh.clean.enable = lib.mkDefault true;
  programs.nh.clean.dates = lib.mkDefault "daily";
  programs.nh.clean.extraArgs = lib.mkDefault "--keep 5 --keep-since 7d";
}
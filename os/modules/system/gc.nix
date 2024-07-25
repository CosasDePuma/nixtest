{ lib, ... }: {
  # Garbage collector: Nix
  nix.gc.automatic = lib.mkDefault true;
  nix.gc.persistent = lib.mkDefault true;
  nix.gc.dates = lib.mkDefault "daily";
  nix.gc.options = lib.mkDefault "--delete-older-than 7d";

  # Optimizer
  nix.settings.auto-optimise-store = lib.mkDefault true;
  nix.optimise.automatic = lib.mkDefault true;
  nix.optimise.dates = lib.mkDefault [ "daily" ];
}
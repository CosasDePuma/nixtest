{ hostname ? "nixos", ... }: { config, lib, ... }: {
  # Hostname
  networking.hostName = lib.mkDefault "${hostname}";

  # Network Manager
  networking.useDHCP = lib.mkDefault false;
  networking.networkmanager.enable = lib.mkDefault true;
  programs.nm-applet.enable = lib.mkDefault true;
}
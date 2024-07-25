{ config, lib, ... }: {
  # GRUB
  boot.loader.grub.enable = lib.mkDefault true;
  boot.loader.grub.efiSupport = lib.mkDefault true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
}
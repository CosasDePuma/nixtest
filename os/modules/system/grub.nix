{ config, lib, ... }: {
  # GRUB
  boot.loader.grub.enable = lib.mkDefault true;
  boot.loader.grub.efiSupport = lib.mkDefault true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.gfxModeEfi = lib.mkDefault "auto";
  boot.loader.grub.gfxModeBios = lib.mkDefault "auto";
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
}
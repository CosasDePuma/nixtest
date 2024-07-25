{ config, lib, ... }:
  let
    resolutions = "1024x768x32,auto";
  in {
    # GRUB
    boot.loader.grub.enable = lib.mkDefault true;
    boot.loader.grub.efiSupport = lib.mkDefault true;
    boot.loader.grub.devices = [ "nodev" ];
    boot.loader.grub.gfxmodeEfi = lib.mkDefault "1024x768x32,auto";
    boot.loader.grub.gfxmodeBios = lib.mkDefault "1024x768x32,auto";
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
  }
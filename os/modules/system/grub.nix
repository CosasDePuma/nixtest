{ lib, ... }:
  let
    resolutions = "1092x1080x30,1024x768x32,auto";
  in {
    # GRUB
    boot.loader.grub.enable = lib.mkDefault true;
    boot.loader.grub.efiSupport = lib.mkDefault true;
    boot.loader.grub.devices = [ "nodev" ];
    boot.loader.grub.gfxmodeEfi = lib.mkDefault "${resolutions}";
    boot.loader.grub.gfxmodeBios = lib.mkDefault "${resolutions}";
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
  }
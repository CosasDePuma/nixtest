{ config, lib, ... }: {
  # MineGRUB
  boot.loader.grub.minegrub-theme.enable = lib.mkDefault true;
  boot.loader.grub.minegrub-theme.splash = "Flakes!";
  boot.loader.grub.minegrub-theme.boot-options-count = 4;
}
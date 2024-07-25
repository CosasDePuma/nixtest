{ lib, ... }: {
  # MineGRUB: Minecraft GRUB theme
  boot.loader.grub.minegrub-theme.enable = lib.mkDefault true;
  boot.loader.grub.minegrub-theme.splash = lib.mkDefault "";
  boot.loader.grub.minegrub-theme.boot-options-count = lib.mkDefault 4;
}
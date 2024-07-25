{ lib, ... }: {
  # MineGRUB: Minecraft GRUB theme
  boot.loader.grub.minegrub-world-sel = {
    enable = true;
    customIcons = [{
      name = "nixos";
      lineBottom = "Survival Mode, No Cheats, Version: 23.11";
      imgName = "nixos";
    }];
  };
}
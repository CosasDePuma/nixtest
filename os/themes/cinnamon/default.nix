{ config, lib, ... }:
  let
    cfg = config.within.theme;
  in {
    imports = [
      ../../modules/desktop
    ];

    options.within.theme = {
      cinnamon = {
        enable = lib.mkOption {
          default = false;
          example = true;
          type = lib.types.bool;
          description = "Enable the Cinnamon desktop environment.";
        };
      };
    };

    config = lib.mkIf cfg.cinnamon.enable {
      within.desktop.awesomevm.enable = lib.mkDefault true;
      within.desktop.awesomevm.rc = lib.mkDefault (builtins.readFile ./awesome.lua);

    };
}
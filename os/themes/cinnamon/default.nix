{ config, lib, ... }:
  let
    cfg = within.theme;
  in {
    imports = [
      ../../modules/desktop
    ];

    options.theme = {
      cinnamon = {
        enable = mkOption {
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
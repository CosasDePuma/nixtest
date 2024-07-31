{ config, lib, pkgs, ... }:
  let
    cfg = config.within.desktop;
  in {
    options.within.desktop = {
      eww = {
        enable = lib.mkEnableOption "eww";

        yuck = lib.mkOption {
          default = null;
          example = ''
            (defwidget bar []
              (centerbox :orientation "h"
                (workspaces)
                (music)))
            ...
          '';
          type = with lib.types; nullOr str;
          description = "Content of the eww configuration file.";
        };
      };
    };

    config = lib.mkIf cfg.eww.enable (
      lib.mkMerge [{
        environment.defaultPackages = with pkgs; [ eww ];
      } (lib.mkIf (cfg.eww.yuck != null) {
        environment.etc."xdg/awesome/rc.lua".text = lib.mkDefault cfg.awesomevm.rc;
      })
    ]);
  }
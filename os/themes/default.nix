{ config, lib, ... }:
  let
    cfg = config.within.theme;
  in {
    options.within = {
      theme = lib.mkOption {
        default = null;
        example = "cinnamon";
        type = with lib.types; nullOr (enum ["none" "cinnamon"]);
        description = ''
          Desktop environment to use. Theme and dependencies will be installed.
          Options are: `none`, `cinnamon`.
        '';
      };
    };

    config =
      if cfg.theme == "cinnamon" then import ./cinnamon /*{ inherit lib; }*/
      else {};
  }
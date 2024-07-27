{ config, lib, ... }:
  let
    cfg = config.within.theme;
  in {

    options.within = {
      theme = lib.mkOption {
        default = null;
        example = "cinnamo";
        type = with lib.types; nullOr (enum ["none" "cinnamo"]);
        description = ''
          Desktop environment to use. Theme and dependencies will be installed.
          Options are: `none`, `cinnamo`.
        '';
      };
    };

    config.private = {
      cinnamo.enable = (cfg.theme == "cinnamo");
    };
  }
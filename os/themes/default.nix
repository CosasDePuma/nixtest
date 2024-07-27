{ config, lib, ... }:
  let
    cfg = config.within.theme;
  in {
    imports = [ ./cinnamo ];

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
      networking.hostName = if cfg.theme == "cinnamo" then "cinnamoroll" else config.private.networking.hostName;
      #cinnamo.enable = (cfg.theme == "cinnamo");
    };
  }
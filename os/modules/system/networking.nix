{ config, lib, ... }:
  let
    cfg = config.mods;
  in {
    options.mods = {
      network = {
        hostname = lib.mkOption {
          default = "nixos";
          example = "metaverse";
          type = lib.types.strMatch "^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$";
          description = ''
            The hostname of the system.
          '';
        };

        ethernet = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = ''
            Enable wired networking.
          '';
        };

        wifi = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = ''
            Enable wireless networking.
          '';
        };
      };
    };

    config = {
      # Hostname
      networking.hostName = lib.mkDefault "pepe"; # cfg.network.hostname;
    };
    /*
    // lib.mkIf cfg.network.ethernet {
      # Network Manager
      networking.useDHCP = lib.mkDefault false;
      networking.networkmanager.enable = lib.mkDefault true;
      programs.nm-applet.enable = lib.mkDefault true;
    } // lib.mkIf cfg.network.wifi {
      # WPA_Supplicant
      networking.wireless.enable = lib.mkDefault true;
    };
    */
  }
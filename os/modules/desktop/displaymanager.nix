{ config, lib, ... }:
  let
    cfg = config.within;
  in {
    options.within = {
      display = {
        manager = lib.mkOption {
          default = "sddm";
          example = "lightdm";
          type = lib.types.enum [ "lightdm" "gdm" "sddm" "startx" ];
          description = ''
            The display manager to use.
            Available options: `lightdm`, `gdm`, `sddm`, `startx`.
          '';
        };

        autologin = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = ''
            Enable auto-login.
          '';
        };
      };
    };

    config = {
      assertions = [{
        assertion = cfg.display.manager == "sddm";
        message = "Currently, only SDDM is supported as a display manager.";
      }];

      # Xorg
      services.xserver.enable = lib.mkDefault true;
      services.libinput.enable = lib.mkDefault true;

      # Autologin
      services.displayManager.autoLogin.enable = lib.mkDefault cfg.display.autologin;
      
      # Display Manager
      services.displayManager.sddm.enable = lib.mkDefault (cfg.display.manager == "sddm");
    };
  }
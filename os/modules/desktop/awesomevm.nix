{ config, lib, pkgs, ... }:
  let
    cfg = config.within.desktop;
  in {
    options.within.desktop = {
      awesomevm = {
        enable = lib.mkOption {
          default = false;
          example = true;
          type = lib.types.bool;
          description = ''
            Enable the AwesomeVM.
          '';
        };
      };
    };

    config = lib.mkIf (cfg.awesomevm.enable) {
      # Xorg
      services.xserver.enable = lib.mkDefault true;
      services.libinput.enable = lib.mkDefault true;

      # Display manager
      services.displayManager.defaultSession = lib.mkDefault "none+awesome";

      # AwesomeVM
      programs.xserver.windowManager.awesome.enable = lib.mkDefault true;
      services.xserver.windowManager.awesome.luaModules = lib.mkDefault (with pkgs.luaPackages; [
        luarocks luadbi-mysql # FIXME: Maybe luadbi-mysql is not necessary
      ]);
    };
  }
  options.within.desktop = {
    awesomevm = {
      enable = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = ''
          Enable the AwesomeVM.
        '';
      };
    };
  };

  config = lib.mkIf (cfg.awesomevm.enable) {
    # Xorg
    services.xserver.enable = lib.mkDefault true;
    services.libinput.enable = lib.mkDefault true;

    # Display manager
    services.displayManager.defaultSession = lib.mkDefault "none+awesome";

    # AwesomeVM
    programs.xserver.windowManager.awesome.enable = lib.mkDefault true;
    services.xserver.windowManager.awesome.luaModules = lib.mkDefault (with pkgs.luaPackages; [
      luarocks luadbi-mysql # FIXME: Maybe luadbi-mysql is not necessary
    ]);
  };
}
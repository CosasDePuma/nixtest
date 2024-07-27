{ config, lib, pkgs, ... }:
  let
    cfg = config.within.desktop;
  in {
    options.within.desktop = {
      awesomevm = {
        enable = lib.mkEnableOption "AwesomeVM";

        rc = lib.mkOption {
          default = null;
          example = ''
            -- AwesomeVM configuration
            -- Theme
            beautiful.init("/etc/xdg/awesome/themes/default/theme.lua")
          '';
          type = with lib.types; nullOr str;
          description = ''
            The AwesomeVM configuration file.
          '';
        };
      };
    };

    config = lib.mkIf cfg.awesomevm.enable (
      lib.mkMerge [{
        # Xorg
        services.xserver.enable = lib.mkDefault true;
        services.libinput.enable = lib.mkDefault true;

        # Display manager
        services.displayManager.defaultSession = lib.mkDefault "none+awesome";

        # AwesomeVM
        services.xserver.windowManager.awesome.enable = true;
        services.xserver.windowManager.awesome.luaModules = lib.mkDefault (with pkgs.luaPackages; [
          luarocks luadbi-mysql # FIXME: Maybe luadbi-mysql is not necessary
        ]);
      } (lib.mkIf (cfg.awesomevm.rc != "${assert cfg.awersome.rc != null; null}") {
        environment.etc."xdg/awesome/rc.lua".text = lib.mkDefault cfg.awesomevm.rc;
      })
    ]);
  }
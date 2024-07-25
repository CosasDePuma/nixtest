{ config, lib, username ? "user", ... }:
  let
    cfg = config.modules;
  in {
    options = {
      modules.nh = lib.mkOption {
        default = null;
        example = "/home/user/.config/nixos";
        type = with lib.types; nullOr path;
        description = ''
          Enable the Nix Helper.
        '';
      };
    };

    config = lib.mkIf (cfg.nh != null) (let
        gcEnabled = builtins.hasAttr "gc" config.modules && config.modules.collector != null;
      in {
        programs.nh.enable = lib.mkDefault true;
        programs.nh.flake = lib.mkDefault cfg.nh;
      } // lib.mkIf gcEnabled {
        # Garbage collector
        nix.gc.automatic = lib.mkForce false;
        programs.nh.clean.enable = lib.mkDefault true;
        programs.nh.clean.dates = lib.mkDefault cfg.gc;
        programs.nh.clean.extraArgs = lib.mkDefault "--keep 5 --keep-since 7d";
      });
  }
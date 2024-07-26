{ config, lib, ... }:
  let
    cfg = config.within;
  in {
    options.within = {
      boot = {
        loader = lib.mkOption {
          default = "grub";
          example = "systemd";
          type = lib.types.enum [ "grub" "systemd" ];
          description = ''
            The bootloader to use.
            Available options: `grub`, `systemd`.
          '';
        };

        theme = lib.mkOption {
          default = null;
          example = "minegrub";
          type = with lib.types; nullOr (enum [ "none" "minegrub" ]);
          description = ''
            The GRUB theme to use.
            Available options: `none`, `minegrub`.
          '';
        };
      };
    };

    config = let
      resolutions = "1092x1080x30,1024x768x32,auto";
      themed = cfg.boot.theme != null && cfg.boot.theme != "none";
      minegrubInstalled = builtins.hasAttr "minegrub-theme" config.boot.loader.grub;
    in lib.mkMerge [
      {
        assertions = [
          (if cfg.boot.theme == "minegrub" && !minegrubInstalled
            then "GRUB theme 'minegrub' is not avaliable. Please, import the 'minegrub-theme' module."
            else null
          )
        ];

        warnings = [
          (if cfg.boot.loader != "grub" && themed
            then "GRUB theme is only available with GRUB bootloader."
            else null
          )
        ];

        boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
      } (lib.mkIf cfg.boot.loader == "systemd" {
        # systemd-boot
        boot.loader.systemd-boot.enable = lib.mkDefault true;
        boot.loader.grub.enable = lib.mkDefault false;
      }) (lib.mkIf cfg.boot.loader == "grub" {
        # GRUB
        boot.loader.grub.enable = lib.mkDefault true;
        boot.loader.grub.efiSupport = lib.mkDefault true;
        boot.loader.grub.devices = lib.mkDefault [ "nodev" ];
        boot.loader.grub.gfxmodeEfi = lib.mkDefault "${resolutions}";
        boot.loader.grub.gfxmodeBios = lib.mkDefault "${resolutions}";
        boot.loader.systemd-boot.enable = lib.mkDefault false;
      }) (lib.mkIf cfg.boot.theme == "minegrub" {
        # GRUB Theme: MineGRUB
        boot.loader.grub.minegrub-theme.enable = lib.mkDefault true;
        boot.loader.grub.minegrub-theme.splash = lib.mkDefault "";
        boot.loader.grub.minegrub-theme.boot-options-count = lib.mkDefault 4;
      })
    ];
  }
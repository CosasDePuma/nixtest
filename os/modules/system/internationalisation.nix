{ config, lib, ... }: {
  # Timezone
  time.timeZone = lib.mkDefault "Europe/Madrid";

  # Language
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  i18n.extraLocaleSettings = lib.mkDefault {
    LC_ADDRESS = lib.mkDefault "es_ES.UTF-8";
    LC_IDENTIFICATION = lib.mkDefault "es_ES.UTF-8";
    LC_MEASUREMENT = lib.mkDefault "es_ES.UTF-8";
    LC_MONETARY = lib.mkDefault "es_ES.UTF-8";
    LC_NAME = lib.mkDefault "es_ES.UTF-8";
    LC_NUMERIC = lib.mkDefault "es_ES.UTF-8";
    LC_PAPER = lib.mkDefault "es_ES.UTF-8";
    LC_TELEPHONE = lib.mkDefault "es_ES.UTF-8";
    LC_TIME = lib.mkDefault "es_ES.UTF-8";
  };

  # Keyboard
  services.xserver.xkb.layout = lib.mkDefault "us,es";
  services.xserver.xkb.variant = lib.mkDefault ",";
  services.xserver.xkb.options = lib.mkDefault "grp:alt_shift_toggle";
}
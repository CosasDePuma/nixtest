{ config, lib, ... }:
  let
    cfg = config.modules.sound;
  in {
    options = {
      modules.sound = lib.mkOption {
        default = "none";
        example = "pipewire";
        type = lib.types.enum [ "none" "pulseaudio" "pipewire" ];
        description = ''
          Sound system to use. Options are: none, pulseaudio, pipewire.
        '';
      };
    };

    config = {
      hardware.pulseaudio.enable = lib.mkDefault (cfg.sound == "pulseaudio");
      hardware.pipewire = lib.mkIf (cfg.sound == "pipewire") {
        enable = lib.mkDefault true;
        pulseaudio.enable = lib.mkDefault true;
        alsa.enable = lib.mkDefault true;
        alsa.support32Bit = lib.mkDefault true;
        jack.enable = lib.mkDefault true;
        security.rtkit.enable = lib.mkDefault true;
      };
    };
}
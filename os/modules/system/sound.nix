{ config, lib, ... }: {
  # Pipewire
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = lib.mkDefault true;
  services.pipewire.enable = lib.mkDefault true;
  services.pipewire.alsa.enable = lib.mkDefault true;
  services.pipewire.alsa.support32Bit = lib.mkDefault true;
  services.pipewire.pulse.enable = lib.mkDefault true;
  services.pipewire.jack.enable = lib.mkDefault true;
}
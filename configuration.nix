{
  config, pkgs,
  hostname ? "nixos",
  system   ? "x86_64-linux",
  username ? "user",
  ...
}: {

  # ---------------------------------------------
  #  NixOS
  # ---------------------------------------------

  system.stateVersion = "unstable";
  imports = [ ./hardware-configuration.nix ];

  # Nixpkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "${system}";

  # Nix
  nix.enable = true;
  nix.channel.enable = true;
  nix.settings.allowed-users = [ "root" "@wheel" ];
  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NH
  programs.nh.enable = true;
  programs.nh.flake = "/etc/nixos";

  # ---------------------------------------------
  #  Bootloader
  # ---------------------------------------------

  # Grub
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.efi.canTouchEfiVariables = true;

  # ---------------------------------------------
  #  Networking
  # ---------------------------------------------

  # Hostname
  networking.hostName = hostname;

  # Network Manager
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # ---------------------------------------------
  #  Internationalisation
  # ---------------------------------------------

  # Timezone
  time.timeZone = "Europe/Madrid";

  # Language
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Keyboard
  services.xserver.xkb.layout = "us,es";
  services.xserver.xkb.variant = ",";
  services.xserver.xkb.options = "grp:alt_shift_toggle";

  # ---------------------------------------------
  #   Desktop / Window Manager
  # ---------------------------------------------

  # X11 Server
  services.xserver.enable = true;

  # X11: Laptop support
  services.libinput.enable = true;

  # Display Manager
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "none+awesome"; # FIXME: Modular (?)

  # Autologin
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${username}";

  # AwesomeVM
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.windowManager.awesome.luaModules = with pkgs.luaPackages; [
    luarocks luadbi-mysql # FIXME: Maybe luadbi-mysql is not necessary
  ];

  # ---------------------------------------------
  #  Sound
  # ---------------------------------------------

  # Pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;

  # ---------------------------------------------
  #  Garbage Collector / Optimizer
  # ---------------------------------------------

  # Optimizer
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "daily" ];
  nix.settings.auto-optimise-store = true;

  # Garbage collector: Nix
  nix.gc.automatic = true;
  nix.gc.persistent = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

  # Garbage collector: NH
  programs.nh.clean.enable = true;
  programs.nh.clean.dates = "daily";
  programs.nh.clean.extraArgs = "--keep 5 --keep-since 7d";

  # ---------------------------------------------
  #  User
  # ---------------------------------------------

  users.users."${username}" = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # ---------------------------------------------
  #  Programs
  # ---------------------------------------------

  environment.systemPackages = with pkgs; [
    git
    nano
    lxqt.qterminal
    vim
    wget
  ];
}

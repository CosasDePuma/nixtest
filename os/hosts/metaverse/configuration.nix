{
  config, pkgs,
  hostname ? "nixos",
  system   ? "x86_64-linux",
  username ? "user",
  ...
}: {
  imports = [
    ../../modules/system
  ];

  within = {
    boot.loader            = "grub";                            # Bootloader
    boot.theme             = "minegrub";                        # Boot theme (Only for GRUB)
    gc                     = "daily";                           # Garbage collector
    languages              = [ "us" "es" ];                     # Keyboard layout, locale and system language
    network.hostname       = "${hostname}";                     # Hostname
    network.networkmanager = true;                              # Managed internet connection
    nh                     = "/home/${username}/.config/nixos"; # Nix Helper
    nix.platform           = "${system}";                       # Architecture and kernel
    nix.version            = "unstable";                        # NixOS version
    sound                  = "pipewire";                        # Sound manager
    timezone               = "Europe/Madrid";                   # Timezone
    user.name              = "${username}";                     # User
  };

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
  #  Programs
  # ---------------------------------------------

  environment.systemPackages = with pkgs; [
    git
    nano
    lxqt.qterminal
    vim
    wget
    (import ../../../scripts/rebuild.nix { inherit pkgs; })
  ];
}

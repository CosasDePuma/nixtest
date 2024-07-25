{
  config, pkgs,
  hostname ? "nixos",
  system   ? "x86_64-linux",
  username ? "user",
  ...
}: {
  imports = [
    ../../modules/system
    ../../modules/third-party/minegrub.nix
  ];

  modules = {

    # ---------------------------------------------
    #   System
    # ---------------------------------------------

    languages        = [ "us" "es" ];                       # Keyboard layout, locale and system language
    network.hostname = "${hostname}";                       # Hostname
    network.ethernet = true;                                # Wired connection
    network.wifi     = true;                                # Wireless connection
    nh               = "/home/${username}/.config/nixos";   # Nix Helper
    nix.platform     = "${system}";                         # Architecture and kernel
    nix.version      = "unstable";                          # NixOS version
    sound            = "pipewire";                          # Sound manager
    timezone         = "Europe/Madrid";                     # Timezone

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
    (import ../../../scripts/rebuild.nix { inherit pkgs; })
  ];
}

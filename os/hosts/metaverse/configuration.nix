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
    (import ../../modules/scripts/rebuild.nix { inherit pkgs; })
  ];
}

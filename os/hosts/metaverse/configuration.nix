{
  config, pkgs,
  hostname ? "nixos",
  system   ? "x86_64-linux",
  username ? "user",
  ...
}: {
  imports = [
    ../../modules/desktop
    ../../modules/system
    ../../themes/cinnamon
  ];

  within = {
    boot.loader              = "grub";                            # GRUB (Bootloader)
    boot.theme               = "minegrub";                        # Boot theme (Only for GRUB)
    desktop.awesomevm.enable = true;                              # AwesomeVM (Window manager)
    display.manager          = "sddm";                            # SSDM (Display manager)
    display.autologin        = true;                              # Auto-login
    gc                       = "daily";                           # Garbage collector
    languages                = [ "us" "es" ];                     # Keyboard layout, locale and system language
    network.hostname         = "${hostname}";                     # Hostname
    network.networkmanager   = true;                              # Managed internet connection
    nh                       = "/home/${username}/.config/nixos"; # Nix Helper
    nix.platform             = "${system}";                       # Architecture and kernel
    nix.version              = "unstable";                        # NixOS version
    sound                    = "pipewire";                        # Sound manager
    timezone                 = "Europe/Madrid";                   # Timezone
    theme.cinnamon.enable    = true;                              # Cinnamon (Desktop environment)
    user.name                = "${username}";                     # User
  };

  # ---------------------------------------------
  #  Programs
  # ---------------------------------------------

  environment.systemPackages = with pkgs; [
    git
    nano
    kitty
    vim
    wget
    (import ../../../scripts/rebuild.nix { inherit pkgs; })
  ];
}

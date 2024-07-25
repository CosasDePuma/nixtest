{ config, lib, modulesPath, ... }: {
  # Profile
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  
  # Modules
  boot.initrd.availableKernelModules = lib.mkDefault [ "xhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Filesystem
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };
  swapDevices = [ ];
}

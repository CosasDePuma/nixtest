{
  description = "Pumita's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # -----------------------
    #  Third-party modules
    # -----------------------
    
    # MineGRUB is a Minecraft GRUB theme.
    minegrub-theme = { url = "github:Lxtharia/minegrub-world-sel-theme"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { nixpkgs, ... } @ inputs:
    let
      extraModules = [
        inputs.minegrub-theme.nixosModules.default
      ];
      os' = import ./os { inherit nixpkgs extraModules; };
  in {
    inherit (os') nixosConfigurations;
  };
}

{
  description = "All my OS in a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Third-party modules
    minegrub = { url = "github:Lxtharia/minegrub-theme"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { nixpkgs, ... } @ inputs:
    let
      lib' = ((import ../lib/flake.nix).outputs { inherit nixpkgs; third-party = inputs; }).lib;
    in {
      nixosConfigurations = lib'.mkHost {
        hostname = "metaverse"; username = "architech";
      };
    };
}
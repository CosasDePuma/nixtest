{
  description = "Pumita's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, os', ... }:
    let
      os' = import ./os/flake.nix { inherit nixpkgs; };
  in {
    inherit (os') nixosConfigurations;
  };
}

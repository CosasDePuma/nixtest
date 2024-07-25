{
  description = "Pumita's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      os' = import ./os { inherit nixpkgs; };
  in {
    inherit (os') nixosConfigurations;
  };
}

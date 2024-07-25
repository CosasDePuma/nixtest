{
  description = "Pumita's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      os' = (import ./os/flake.nix).outputs { inherit nixpkgs; };
  in {
    inherit (os') nixosConfigurations;
  };
}

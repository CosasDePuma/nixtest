{
  description = "Pumita's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    os' = { url = "path:./os"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, os', ... }: {
    inherit (os') nixosConfigurations;
  };
}

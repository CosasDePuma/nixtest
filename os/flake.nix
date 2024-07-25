{
  description = "All my OS in a flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      lib' = (import ./lib/flake.nix).outputs { inherit nixpkgs; };
    in {
      nixosConfigurations = lib'.mkHost {
        hostname = "B105"; username = "architech";
      };
    };
}

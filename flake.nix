{
  description = "All my OS in a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      # mkHost :: set -> set
      # Generates OS configuration for `x86_64` and `aarch64` architecture types.
      # Input options: { hostname, user, ... }
      mkHost = options:
        let
          defaults = { hostname = "nixos"; username = "user"; };
          opts = defaults // options;
        in
          builtins.listToAttrs (map (arch: {
            name = "${opts.hostname}-${arch}";
            value = nixpkgs.lib.nixosSystem {
              system = "${arch}-linux";
              modules = [
                ./hardware-configuration.nix
                ./configuration.nix # TODO: Import from hostname config
              ];
              specialArgs = { inherit (opts) hostname username; system = "${arch}-linux"; };
            };
          }) ["x86_64" "aarch64"]);
    in {
      nixosConfigurations = mkHost { hostname = "B105"; username = "architech"; };
    };
}

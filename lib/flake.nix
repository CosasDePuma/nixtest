{
  description = "My own flake support library";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { nixpkgs, ... }:
    let

      # mkHost :: set: list: -> set
      # Generates OS configuration for `x86_64` and `aarch64` architecture types.
      # Input options: { hostname, user, ... }
      mkHost = options: third-party:
        let
          defaults = {
            hostname      = "nixos";
            username      = "user";
          };
          opts = defaults // options;
        in
          builtins.listToAttrs (map (arch: {
            name = "${opts.hostname}-${arch}";
            value = nixpkgs.lib.nixosSystem {
              system = "${arch}-linux";
              modules = third-party ++ [
                # Configuration
                ../hardware-configuration.nix
                ../os/hosts/${opts.hostname}/configuration.nix
              ];
              specialArgs = { inherit (opts) hostname username; system = "${arch}-linux"; };
            };
          }) ["x86_64" "aarch64"]);

    in {
      lib = {
        inherit
          mkHost;
      };
    };
}

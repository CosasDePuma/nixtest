{
  description = "All my OS in a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    lib' = { url = "./lib"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, lib', ... }: {
    nixosConfigurations = lib'.mkHost {
      hostname = "B105"; username = "architech";
    };
  };
}

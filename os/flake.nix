{
  description = "All my OS in a flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      lib' = ((import ../lib/flake.nix).outputs { inherit nixpkgs; }).lib;
      third-party' = [
        # MineGRUB: Minecraft-themed GRUB
        ((import github:Lxtharia/minegrub-theme).outputs { inherit nixpkgs; }).nixosModules.default
      ];
    in {
      nixosConfigurations = lib'.mkHost {
        hostname = "metaverse"; username = "architech";
      } third-party';
    };
}
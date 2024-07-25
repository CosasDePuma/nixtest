{ nixpkgs }:
  let
    lib' = import ../lib { inherit nixpkgs; };
  in {
    nixosConfigurations = lib'.mkHost {
      hostname = "metaverse"; username = "architech";
    };
  }
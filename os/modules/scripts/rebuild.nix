{ pkgs, ... }:
  pkgs.writeShellScriptBin "nh-rebuild" ''
    #!/usr/bin/env sh
    command -v nh >/dev/null 2>&1 || {
      echo "nh is not installed. Aborting." >&2
      exit 1
    }
    ${pkgs.nh}/bin/nh os switch -H "$(hostname)-$(uname -m)"
  ''
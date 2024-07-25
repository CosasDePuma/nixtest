{ pkgs, ... }:
  pkgs.writeShellScriptBin "nh-rebuild" ''
    # Check if nh is installed
    command -v nh >/dev/null 2>&1 || {
      echo "nh is not installed. Aborting." >&2
      exit 1
    }
    # Check if flake is a git repository
    ${pkgs.git}/bin/git -C "${"${FLAKE}"}" rev-parse --is-inside-work-tree >/dev/null 2>&1 && {
      ${pkgs.git}/bin/git -C "\${FLAKE}" add -A
    }
    ${pkgs.nh}/bin/nh os switch -H "$(hostname)-$(uname -m)"
  ''
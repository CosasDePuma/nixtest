{ config, lib, ... }: let cfg = config._private.cinnamo; in {
  imports = [ ../../modules ];

  options._private.cinnamo.enable = lib.mkEnableOption "cinnamoroll desktop environment";

  config = lib.mkIf cfg.enable {
    within.desktop.awesomevm.enable = lib.mkDefault true;
    within.desktop.awesomevm.rc = lib.mkDefault (builtins.readFile ./awesome.lua);
  };
}
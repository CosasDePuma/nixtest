{ config, lib, ... }: let cfg = config.private.cinnamo; in {
  imports = [ ../../modules ];

  options.private.cinnamo.enable = lib.mkEnableOption "cinnamoroll desktop environment";

  config = lib.mkIf cfg.enable {
    config.within.desktop.awesomevm.enable = lib.mkDefault true;
    #within.desktop.awesomevm.rc = lib.mkDefault (builtins.readFile ./awesome.lua);
  };
}
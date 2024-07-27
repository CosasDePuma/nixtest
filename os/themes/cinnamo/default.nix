{ config, lib, ... }: let cfg = config._private.theme.cinnamo; in {

  options._private.theme.cinnamo.enable = lib.mkEnableOption "cinnamoroll desktop environment";

  config = lib.mkIf cfg.enable {
    #config.within.desktop.awesomevm.enable = lib.mkDefault true;
    networking.hostName = "cinnamoroll";
    #within.desktop.awesomevm.rc = lib.mkDefault (builtins.readFile ./awesome.lua);
  };
}
{ config, lib, ... }:
  let
    cfg = config.within.theme;
  in {
    imports = [ ../../os/modules ];
  
    within.desktop.awesomevm.enable = lib.mkDefault true;
    within.desktop.awesomevm.rc = lib.mkDefault (builtins.readFile ./awesome.lua);
  }
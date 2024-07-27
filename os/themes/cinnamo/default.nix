{ config, lib, ... }: let cfg = config.private.cinnamo; in {
  imports = [ ../../modules ];

  options.private.cinnamo.enable = lib.mkOption {
    default = false;
    example = true;
    type = lib.types.bool;
    description = "Enable the cinnamoroll desktop environment";
  };

  config = lib.mkIf cfg.enable {
    within.desktop.awesomevm.enable = lib.mkDefault true;
    within.desktop.awesomevm.rc = lib.mkDefault (builtins.readFile ./awesome.lua);
  };
}
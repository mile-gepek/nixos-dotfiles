{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  cfg = config.safeeyes-config;
in
{
  options.safeeyes-config = {
    enable = lib.mkEnableOption "Enable safeeyes config";
  };

  config = lib.mkIf cfg.enable {
    services.safeeyes.enable = true;
  };
}

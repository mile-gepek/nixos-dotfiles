{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  cfg = config.noctalia-config;
in
{
  options.noctalia-config = {
    enable = lib.mkEnableOption "Enable noctalia config";
  };

  config = lib.mkIf cfg.enable {
    programs.noctalia-shell = {
      enable = true;
      settings = builtins.fromJSON(builtins.readFile ./settings.json);
    };
  };
}

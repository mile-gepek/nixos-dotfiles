{ pkgs, lib, ... }:

let
  cfg = config.direnv-config;
in
{
  options.direnv-config = {
    enable = lib.mkEnableOption "Enable nix-direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
    }
  }
}

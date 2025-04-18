{ lib, config, pkgs, ... }:

let
  cfg = config.fish-config;
in
{
  options.fish-config = {
    enable = lib.mkEnableOption "Enable fish and starship config";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fish = {
      enable = true;
      shellInit = ''
        set fish_greeting
        starship init fish | source
      '';
      shellAliases = {
        nix-shell = "nix-shell --run fish";
      };
    };
  };
}

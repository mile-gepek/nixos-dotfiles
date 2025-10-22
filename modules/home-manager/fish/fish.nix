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
    };

    programs.fish = {
      enable = true;
      shellInit = ''
        set fish_greeting
        starship init fish | source
      '';
      shellAliases = {
        nixsh = "nix-shell --command $SHELL";
        nixdev = "nix develop --command $SHELL";
        lg = "lazygit";
      };
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

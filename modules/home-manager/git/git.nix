{ config, lib, ... }:

let
  cfg = config.git-config;
in
{
  options.git-config = {
    git.enable = lib.mkEnableOption "Enable git config";
    lazygit.enable = lib.mkEnableOption "Enable lazygit config";
  };

  config = {
    programs.git = lib.mkIf cfg.git.enable {
      enable = true;
      userName = "mile gepek";
      userEmail = "theontley@gmail.com";
    };

    programs.lazygit = lib.mkIf cfg.lazygit.enable {
      enable = true;
    };
  };
}

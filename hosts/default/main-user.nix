{ lib, config, pkgs, ... }:

let
  cfg = config.mainuser;
in
{
  options.mainuser = {
    enable = lib.mkEnableOption "enable user module";

    username = lib.mkOption {
      default = "leo";
      description = ''
        username of the main user
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    users.users.${cfg.username} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      description = cfg.username;
      shell = pkgs.fish;
    };
  };
}

{ lib, pkgs, config, ... }:

let
  cfg = config.ghostty-config;
in
{
  options.ghostty-config = {
    enable = lib.mkEnableOption "Enable ghostty config";
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        font-family = "\"Monaspace Neon Frozen\"";
        font-style = "\"SemiBold\"";
        font-style-bold = "\"Bold\"";
        font-style-italic = "\"SemiBold Italic\"";
        font-style-bold-italic = "\"Bold Italic\"";
        font-feature = "+calt +liga +ss01 +ss02 +ss03 +ss04 +ss05 +ss06 +ss07 +ss09 +ss10";
        
        font-size = 15;
      
        adjust-cell-height = "20%";
        background = "#1f1f28";
      };
    };
  };
}

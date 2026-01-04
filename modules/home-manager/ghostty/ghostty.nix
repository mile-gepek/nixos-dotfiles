{ lib, pkgs, config, inputs, ... }:

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
      package = inputs.ghostty.packages.${pkgs.stdenv.system}.default;
      enableFishIntegration = true;
      settings = {
        font-family = "\"Monaspace Argon Var\"";
        font-style = "\"SemiBold\"";
        font-style-bold = "\"Bold\"";
        font-style-italic = "\"SemiBold Italic\"";
        font-style-bold-italic = "\"Bold Italic\"";
        font-feature = ["+calt" "+liga" "+ss01" "+ss02" "+ss03" "+ss04" "+ss05" "+ss06" "+ss07" "+ss09" "+ss10"];
        font-size = 15;
      
        adjust-cell-height = "20%";
        background = "#1f1f28";

        gtk-single-instance=false;
      };
    };
  };
}

{ config, lib, ... }:

let
  cfg = config.waybar-config;
in {
  options.waybar-config = {
    enable = lib.mkEnableOption "Enable waybar config";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "hyprland/language"
          "pulseaudio"
          "clock"
          "network"
        ];

        "hyprland/language" = {
          format-en = "EN";
          format-hr = "HR";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" =  "";
            "2" =  "󰈹";
            "3" =  "";
            default =  "";
            persistent =  "";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
        };

        clock = {
          format = "{:%Y-%m-%d | %H:%M}";
          format-alt = "{:%Y-%m-%d}";
        };

        network = {
          format-wifi =  "{essid} ({signalStrength}%) ";
          format-ethernet =  "{ifname}: {ipaddr}/{cidr} ";
          format-disconnected =  "Disconnected ⚠";
          interval =  7;
        };

        pulseaudio =  {
          format =  "{volume}% {icon}";
          format-bluetooth =  "{volume}% {icon}";
          format-muted =  "";
          format-icons =  {
              headphones =  "";
              handsfree =  "";
              headset =  "";
              phone =  "";
              portable =  "";
              car =  "";
              default =  ["" ""];
          };
          on-click =  "pavucontrol";
        };
      };

      style = (builtins.readFile ./style.css);
    };
  };
}

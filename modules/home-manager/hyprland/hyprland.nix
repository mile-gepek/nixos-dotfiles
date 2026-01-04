{ pkgs, lib, config, ... }:

let
  cfg = config.hyprland-config;
in
{
  options = {
    hyprland-config = {
      enable = lib.mkEnableOption "Enable hyprland config";
      layout = lib.mkOption {
        default = "dwindle";
        description = ''
          Hyprland window layout
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        monitor = ", highres@highrr, auto, auto";
      
        general = {
          layout = cfg.layout;
          border_size = 2;

          gaps_in = 5;
          gaps_out = 20;

          resize_on_border = false;
        };

        decoration = {
          blur.enabled = false;
          shadow.enabled = true;

          rounding = 5;
          rounding_power = 4.0;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        layerrule = [
          "noanim, selection"
        ];

        "$mod" = "ALT";

        bind = [
          "$mod, W, exec, firefox"
          "$mod, Return, exec, ghostty"
          "$mod, R, exec, rofi -show drun"
          "$mod, Q, killactive"
          "$mod SHIFT CTRL, Q, exit"
          "$mod, E, exec, nautilus"
          "$mod, V, togglefloating"
          "$mod, T, togglesplit"
          "$mod, J, movefocus, l"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, d"
          "$mod, L, movefocus, r"
          "$mod, M, togglespecialworkspace, magic"
          "$mod SHIFT, M, movetoworkspace, special:magic"
          "$mod SHIFT, S, exec, hyprshot -m region"
          ", Print, exec, hyprshot -m output"
        ] ++ (
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
        );

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        input = {
          kb_layout = "us,hr";
          kb_options = "grp:alt_space_toggle";

          sensitivity = -0.6;

          repeat_delay = 200;
        };

        misc  = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        env = [
          "HYPRCURSOR_THEME, Bibata-Modern-Classis"
          "HYPRCURSOR_SIZE, 24"
          "HYPRSHOT_DIR, Pictures/Screenshots"
        ];

        exec-once = [
          "hyprctl setcursor Bibata-Modern-Classic 24"
          "waybar"
        ];

        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "float,class:^(safeeyes)$"
        ];
      };
    };
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ "~/wallpapers/idk dragon cool.jpeg" ];
        wallpaper = [ "DP-1,~/wallpapers/idk dragon cool.jpeg" ];
      };
    };
  };
}

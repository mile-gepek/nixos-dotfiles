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

          rounding = 10;
          rounding_power = 4.0;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        "$mod" = "ALT";

        bind = [
          "$mod, W, exec, firefox"
          "$mod, Return, exec, ghostty"
          "$mod, R, exec, noctalia-shell ipc call launcher toggle"
          "$mod, Q, killactive"
          "$mod SHIFT CTRL, Q, exec, noctalia-shell ipc call sessionMenu toggle"
          "$mod, E, exec, nautilus"
          "$mod, V, togglefloating"
          "$mod, T, togglesplit"
          "$mod, J, movefocus, l"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, d"
          "$mod, ;, movefocus, r"
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
          "noctalia-shell"
        ];

        windowrule = [
          "match:class .*, suppress_event maximize"
          "match:class ^$, match:title ^$, match:xwayland on, no_focus on, float on, fullscreen off, pin off"
          "match:class ^(safeeyes)$, float on,"
        ];
      };
    };
    services.hyprpaper = {
      enable = true;
      settings = {
        wallpaper = [
          {
            monitor = "DP-1";
            path = "~/wallpapers/idk dragon cool.jpeg";
          }
        ];
      };
    };
  };
}

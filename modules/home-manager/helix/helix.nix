{ lib, pkgs, config, inputs, ... }:

let
  cfg = config.helix-config;
in
{
  options.helix-config = {
    enable = lib.mkEnableOption "Enable helix config";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      package = inputs.helix.packages.${pkgs.stdenv.system}.default;
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "gruvbox-material-no-background";
        editor = {
          line-number = "relative";
          color-modes = true;
          rainbow-brackets = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          
          indent-guides = {
            render = true;
            character = "┊";
          };

          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "warning";
          };
        };
      };

      themes = {
        gruvbox-material-no-background = {
          inherits = "gruvbox-material";
          "ui.background" = { };
        };
      };

      languages = {
        language = [
          {
            name = "python";
            language-servers = [ "ruff" "basedpyright" ];
            auto-format = true;
            debugger = {
              name = "debugpy";
              transport = "stdio";
              command = "python";
              args = [ "-m" "debugpy.adapter" ];
              templates = [
                  {
                  name = "module";
                  request = "launch";
                  # completion = [
                  #   { name = "module"; completion = "directory"; default = "."; }
                  #   # filename/directory autocompletions are canonicalized which breaks debuggers when trying to debug modules
                  # ];
                  args = {
                    mode = "debug";
                    module = "absolute_unit";
                  };
                }
              ];
            };
          }
        ];
      };
    };
  };
}


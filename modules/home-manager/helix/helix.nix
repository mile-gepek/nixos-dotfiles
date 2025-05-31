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
          completion-replace = true;
          preview-completion-insert = false;
          color-modes = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          
          indent-guides = {
            render = true;
            character = "╎";
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
            language-servers = [ "ruff" "pyright" ];
          }
        ];

        language-server = {
          ruff = {
            command = "ruff";
            args = [ "server" ];
          };
          pyright = {
            command = "pyright-langserver";
            args = [ "--stdio" ];
          };
        };
      };
    };
  };
}


{ ... }:

{
  imports = [
    ./fish/fish.nix
    ./fonts.nix
    ./git/git.nix
    ./ghostty/ghostty.nix
    ./helix/helix.nix
    ./hyprland/hyprland.nix
    ./waybar/waybar.nix
  ];
  fish-config.enable = true;
  git-config.git.enable = true;
  git-config.lazygit.enable = true;
  ghostty-config.enable = true;
  helix-config.enable = true;
  hyprland-config.enable = true;
  hyprland-config.layout = "dwindle";
  waybar-config.enable = true;
}

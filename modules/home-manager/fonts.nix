{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    pkgs.monaspace
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.caskaydia-cove
  ];
}

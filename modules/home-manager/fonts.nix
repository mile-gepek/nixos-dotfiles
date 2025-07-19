{ pkgs, ... }:

{
  home.packages = with pkgs; [
    monaspace
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
  ];
}

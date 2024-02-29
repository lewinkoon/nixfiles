{ config, pkgs, ... }:

{
  home.username = "lewin";
  home.homeDirectory = "/home/lewin";
  home.packages = with pkgs; [
    hugo
  ];
  home.stateVersion = "23.11";

  programs.firefox.enable = true;
 
  programs.git.enable = true;
  programs.git.userName = "Lewin";
  programs.git.userEmail = "lewinkoon+github@gmail.com";
  programs.git.extraConfig.init.defaultBranch = "main";

  programs.home-manager.enable = true;
}

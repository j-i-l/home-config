{ config, pkgs, ... }:
{
  programs.bash.enable = false;
  programs.git.enable = true;

  # Example: Add a package to the home.packages list.
  home.packages = [
    pkgs.htop
    pkgs.btop
    pkgs.ranger
    pkgs.nmap
    # pkgs.tmux
  ];
}

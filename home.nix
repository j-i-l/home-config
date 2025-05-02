{ config, pkgs, ... }:

{
  imports = [
    ./basics/config.nix
    ./basics/programs.nix
  ];
  # Set your username and home directory.
  home.username = "jonas";
  home.homeDirectory = "/home/jonas";

  # State version should be pinned using home.stateVersion.
  # Adjust the version below to the version of Home Manager you're using.
  home.stateVersion = "24.11";

  # Enable home-manager for further runs
  programs.home-manager.enable = true;

}


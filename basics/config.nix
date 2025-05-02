{ config, pkgs, ... }:
let
  # Define the Oh My Zsh package from the GitHub repository
  ohMyZsh = pkgs.fetchFromGitHub {
    owner = "ohmyzsh";
    repo = "ohmyzsh";
    rev = "f6a7bbf81a18d30f75bad72de3398d0f55c8792b";
    sha256 = "sha256-2SoiItbJ/WQ+Kv8gM+nBjco0BiX+CYoJ4d+yj71XckE=";
  };
  zshAutosuggestions = pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-autosuggestions";
    rev = "master";
    sha256 = "sha256-85aw9OM2pQPsWklXjuNOzp9El1MsNb+cIiZQVHUzBnk=";
  };
  zshSyntaxHighlighting = pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-syntax-highlighting";
    rev = "5eb677bb0fa9a3e60f0eff031dc13926e093df92";
    sha256 = "sha256-KRsQEDRsJdF7LGOMTZuqfbW6xdV5S38wlgdcCM98Y/Q=";
  };
  zshThemeAngosterzak = pkgs.fetchFromGitHub {
    owner = "zakaziko99";
    repo = "agnosterzak-ohmyzsh-theme";
    rev = "312f93f00b199d6c2506221f8366a7f216023100";
    sha256 = "sha256-N3xEJUztZwEt8ERV0Zn1G909Ncg/bIzeYYWOK67ks4o=";
  };

in 
{

  # Set default editor
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Adding config files
  home.file.".profile".text = ''
    # ~/.profile: executed by the command interpreter for login shells.
    # This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
    # exists.
    # see /usr/share/doc/bash/examples/startup-files for examples.
    # the files are located in the bash-doc package.
    
    # the default umask is set in /etc/profile; for setting the umask
    # for ssh logins, install and configure the libpam-umask package.
    #umask 022
    
    # if running bash
    if [ -n "$BASH_VERSION" ]; then
        # include .bashrc if it exists
        if [ -f "$HOME/.bashrc" ]; then
    	. "$HOME/.bashrc"
        fi
    fi
    
    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
        PATH="$HOME/bin:$PATH"
    fi
    
    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi
    . "$HOME/.cargo/env"
  '';

  # deploy basic configs
  home.file.".bashrc".source = ./programs/bash/.bashrc;
  # zhs config
  home.file.".zshrc".source = ./programs/zsh/.zshrc;
  home.file.".oh-my-zsh".source = ohMyZsh;
  # ZSH custom plugins (~/.oh-my-zsh-custom needs to be set in the .zshrc!)
  home.file.".oh-my-zsh-custom/plugins/zsh-syntax-highlighting".source = zshSyntaxHighlighting;
  home.file.".oh-my-zsh-custom/plugins/zsh-autosuggestions".source = zshAutosuggestions;
  # ZSH custom themes
  home.file.".oh-my-zsh-custom/themes/agnosterzak.zsh-theme".source =
    "${zshThemeAngosterzak}/agnosterzak.zsh-theme";

  # You can also enable other Home Manager modules.
  # E.g., if you use Nix's Home Manager channel 'programs.zsh', you may enable it like this:
  programs.zsh.enable = true;

  # git config
  programs.git = {
    enable = true;
    includes = [
      # { # context 1 
      #   condition = "gitdir:~/Dev/";
      #   contents.user = {
      #     email = "";
      #     name = "";
      #   };
      # }
      { # context 1
        contents.user = {
          email = "j-i-l@t4d.ch";
          name = "Jonas I. Liechti";
        };
      }
    ];
  };

}

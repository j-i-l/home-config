{
  description = "J-I-L's Home Manager Configuration";

  inputs = {
    # Use a specific nixpkgs channel, e.g. nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home Manager from the official repository
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      # Import Home Manager lib from the Home Manager input
      hmLib = home-manager.lib;
    in {
      # Declare a Home Manager configuration for a given username.
      # Replace "myuser" with your actual username.
      homeConfigurations = {
        jonas = hmLib.homeManagerConfiguration {
          inherit pkgs;
          # Optionally set the extra special options or program paths if needed
          # For example, you might want to override the location of the home directory if necessary.
          modules = [
            ./home.nix
          ];
          # Optionally set a name for your configuration build.
          extraSpecialArgs = { };
        };
      };

      # Optionally, you can add a NixOS configuration if you are running NixOS.
      # But on Ubuntu you will just use the Home Manager configuration.
    };
}


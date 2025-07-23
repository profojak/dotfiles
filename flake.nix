{
  description = "Nix System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-cask,
      treefmt-nix,
      systems,
    }@inputs:
    let
      # Configurations.
      configurations = import ./lib/configurations.nix { inherit inputs; };

      # Formatter.
      treefmt = import ./lib/treefmt.nix { inherit inputs; };
    in
    {
      # Configuration for `darwin-rebuild --flake .#configuration`.
      darwinConfigurations = {
        "BobBook" = configurations.makeDarwin {
          host = "BobBook";
          session = "BobAqua";
          admin = "profojak";
        };
      };

      # Configuration for `home-manager --flake .#configuration`.
      homeConfigurations = {
        "profojak.aarch64-darwin" = configurations.makeHome {
          user = "profojak";
          system = "aarch64-darwin";
        };
      };

      # Formatter for `nix fmt`.
      formatter = treefmt.formatter;

      # Checks for `nix flake check`.
      checks = treefmt.checks;
    };
}

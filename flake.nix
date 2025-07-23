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
      inherit (self.outputs) lib;
    in
    {
      # Configuration for `darwin-rebuild --flake .#configuration`.
      darwinConfigurations = {
        "BobBook" = lib.configurations.makeDarwin {
          host = "BobBook";
          session = "BobAqua";
          admin = "profojak";
        };
      };

      # Configuration for `home-manager --flake .#configuration`.
      homeConfigurations = {
        "profojak.aarch64-darwin" = lib.configurations.makeHome {
          user = "profojak";
          system = "aarch64-darwin";
        };
      };

      # Library of helper functions.
      lib = import ./lib { inherit inputs; };

      # Formatter for `nix fmt`.
      formatter = lib.treefmt.formatter;

      # Checks for `nix flake check`.
      checks = lib.treefmt.checks;
    };
}

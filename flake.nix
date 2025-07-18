{
  description = "Nix System Configuration";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs-unstable,
      nix-darwin,
      home-manager,
      treefmt-nix,
      systems,
    }:
    let
      # Configurations.
      configurations = import ./lib/configurations.nix {
        inherit inputs;
        pkgs = nixpkgs-unstable;
      };

      # Formatter.
      treefmt = import ./lib/treefmt.nix {
        inherit inputs;
        pkgs = nixpkgs-unstable;
      };
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

{ inputs }:
{
  # Generate configuration for nix-darwin.
  makeDarwin =
    {
      host,
      session,
      admin,
    }@args:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs args; };
      modules = [
        ../hosts/${host}.nix
        ../sessions/${session}.nix
      ];
    };

  # Generate configuration for home-manager.
  makeHome =
    { user, system }@args:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs args; };
      modules = [ ../users/${user}.nix ];
    };
}

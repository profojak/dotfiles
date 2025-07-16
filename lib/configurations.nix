{ pkgs, inputs }:
{
  # Generate configuration for nix-darwin.
  makeDarwin =
    {
      host,
      session,
      admin,
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit
          inputs
          host
          session
          admin
          ;
      };
      modules = [ ../hosts/${host}.nix ];
    };

  # Generate configuration for home-manager.
  makeHome =
    { user, system }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs user system; };
      modules = [ ../users/${user}.nix ];
    };
}

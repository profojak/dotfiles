{ inputs }:
{
  configurations = import ./configurations.nix { inherit inputs; };
  treefmt = import ./treefmt.nix { inherit inputs; };
}

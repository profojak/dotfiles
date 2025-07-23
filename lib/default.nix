{ inputs }:
let
  lib = {
    configurations = import ./configurations.nix { inherit inputs; };
    iterators = import ./iterators.nix { inherit inputs; };
    treefmt = import ./treefmt.nix {
      inherit inputs;
      inherit (lib) iterators;
    };
  };
in
lib

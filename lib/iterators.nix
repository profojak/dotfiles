{ inputs }:
let
  supportedSystems = [ "aarch64-darwin" ];
  iterators = {
    # Iterate over each supported system.
    eachSystem = inputs.nixpkgs.lib.genAttrs supportedSystems;

    # Iterate over packages of each supported system.
    eachPackage = f: iterators.eachSystem (system: f inputs.nixpkgs.legacyPackages.${system});
  };
in
iterators

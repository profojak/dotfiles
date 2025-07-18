{ pkgs, inputs }:
let
  # Iterate over each system.
  eachSystem = f: pkgs.lib.genAttrs (import inputs.systems) (system: f pkgs.legacyPackages.${system});

  # Configure Treefmt.
  configuration = eachSystem (
    p:
    inputs.treefmt-nix.lib.evalModule p {
      projectRootFile = "flake.nix";

      # Format using the official nixfmt formatter and be strict.
      programs.nixfmt = {
        enable = true;
        strict = true;
      };

      # Exclude `flake.lock`.
      settings.formatter.nixfmt.excludes = [ "flake.lock" ];
    }
  );
in
{
  # Formatter for `nix fmt`.
  formatter = eachSystem (p: configuration.${p.system}.config.build.wrapper);

  # Formatter checks for `nix flake check`.
  checks = eachSystem (p: {
    formatting = configuration.${p.system}.config.build.check inputs.self;
  });
}

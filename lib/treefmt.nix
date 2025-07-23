{ inputs, iterators }:
let
  # Configure Treefmt.
  configuration = iterators.eachPackage (
    pkgs:
    inputs.treefmt-nix.lib.evalModule pkgs {
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
  formatter = iterators.eachPackage (pkgs: configuration.${pkgs.system}.config.build.wrapper);

  # Formatter checks for `nix flake check`.
  checks = iterators.eachPackage (pkgs: {
    formatting = configuration.${pkgs.system}.config.build.check inputs.self;
  });
}

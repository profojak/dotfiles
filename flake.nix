{
  description = "BobBook";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs = { self, nixpkgs, llm-agents }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      agents = llm-agents.packages.${system};
    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "BobBook";
        paths = builtins.attrValues {
          inherit (pkgs)
          helix;
          inherit (agents)
          pi;
        };
      };
    };
}

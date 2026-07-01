{
  description = "BobBook";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
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

{ args, ... }:
{
  imports = [ ../modules/helix.nix ];

  home = {
    username = args.user;
    homeDirectory = "/Users/${args.user}";

    # Set compatible home-manager release.
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}

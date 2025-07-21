{
  imports = [ ../modules/helix.nix ];

  home = {
    username = "profojak";
    homeDirectory = "/Users/profojak";

    # Set compatible home-manager release.
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}

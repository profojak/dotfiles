{
  pkgs,
  inputs,
  host,
  admin,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    (
      { config, ... }:
      {
        # Pass all taps from nix-homebrew to nix-darwin.homebrew.
        homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
      }
    )
  ];

  nix = {
    enable = true;
    checkConfig = true;
    settings = {
      # Allow `nix flake` command, and allow admin user to connect to Nix daemon.
      experimental-features = "nix-command flakes";
      allowed-users = [ admin ];
      # Allow builder to use all available CPU cores, and all available logical cores.
      cores = 0;
      max-jobs = "auto";
      # Download binaries only from cryptographically signed binary caches.
      require-sigs = true;
      # Disable automatic optimization on store update, and sandboxed builds.
      auto-optimise-store = false;
      sandbox = false;
    };
    # Disable `nix-channel`, automatic garbage collector, and automatic store optimizer.
    channel.enable = false;
    gc.automatic = false;
    optimise.automatic = false;
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  documentation = {
    enable = true;
    man.enable = true;
    info.enable = false;
    doc.enable = false;
  };

  programs = {
    zsh.enable = true;
    man.enable = true;
    info.enable = false;
  };

  environment = {
    systemPackages = with pkgs; [ ];
    variables = {
      EDITOR = "vim";
      HOMEBREW_NO_ANALYTICS = "1";
    };
    # Do not set path to nix-darwin configuration, this is flake-based system!
    darwinConfig = null;
  };

  homebrew = {
    enable = true;
    global = {
      # Update automatically when running `brew install`, `brew upgrade`, …
      autoUpdate = true;
      # Generate lockfile when manually invoking `brew bundle`.
      lockfiles = true;
    };
    # Upgrade casks even if unversioned or having built-in updating.
    greedyCasks = true;
    onActivation = {
      # Updates and upgrades automatically when running nix-darwin system activation.
      autoUpdate = true;
      upgrade = true;
      # Uninstall and remove all associated files.
      cleanup = "zap";
    };
    casks = [
      "aldente"
      "zed"
    ];
    masApps = {
      "AdBlock Pro" = 1018301773;
    };
  };

  nix-homebrew = {
    enable = true;
    user = admin;
    taps."homebrew/homebrew-cask" = inputs.homebrew-cask;
    # Disallow `brew tap` to add taps.
    mutableTaps = false;
  };

  networking = {
    computerName = host;
    hostName = host;
    wakeOnLan.enable = false;
  };

  power = {
    restartAfterFreeze = true;
    sleep = {
      computer = "never";
      display = 180;
      harddisk = 10;
      allowSleepByPowerButton = false;
    };
  };

  security = {
    # Enable Touch ID with sudo.
    pam.services.sudo_local.touchIdAuth = true;
  };

  system = {
    primaryUser = admin;
    # Set compatible nix-darwin release, and Git revision of top-level system flake.
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    # Verify Nix build users validation checks, and macOS version.
    checks = {
      verifyBuildUsers = true;
      verifyMacOSVersion = true;
    };
  };
}

{
  pkgs,
  inputs,
  host,
  admin,
  ...
}:
{
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
    };
    # Do not set path to nix-darwin configuration, this is flake-based system!
    darwinConfig = null;
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

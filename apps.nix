{ pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Prompt
    pure-prompt

    # Programming
    wgo

    ## Nix
    nixd
    nixfmt-rfc-style

    ## Haskell

    ## Node
    nodejs
    pnpm

    ## Rust
    rustup

    ## Go
    go
    gopls
    gotools

    ## Typst
    typst
    tinymist

    # CLI tools

    ## General
    helix
    btop
    fastfetch

    ## Git
    gh
    lazygit

    ## TUI Apps
    circumflex
    yazi

    ## Encryption
    age
  ];

  environment.variables = {
    EDITOR = "hx";

    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_INSECURE_REDIRECT = "1";
    HOMEBREW_NO_EMOJI = "1";
    HOMEBREW_NO_ENV_HINTS = "0";
  };

  homebrew = {
    enable = true;
    # caskArgs.require_sha = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    casks = [
      "firefox" # Popular open-source web browser
      "google-chrome" # For Chromecast
      "kitty" # Fast GPU-accelerated terminal emulator
      "visual-studio-code" # Popular code editor with extensive plugin support
      "orbstack" # Modern Docker and Linux container manager
      "discord" # Gaming and community chat platform
      "tailscale" # Zero-config VPN for secure networking
      "iina" # Modern media player for macOS
      "transmission" # Lightweight BitTorrent client
      "alt-tab" # Windows-style alt-tab window switcher
      "jordanbaird-ice" # Window management and workspace organization
      "altserver" # iOS sideloading utility
      "ollama" # Get up and running with large language models locally
      "krita" # Free and open-source painting and sketching program
    ];
    masApps = {
      "Amphetamine" = 937984704;
      "Klack" = 6446206067;
    };
  };
}

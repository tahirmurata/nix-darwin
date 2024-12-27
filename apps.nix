{ pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Development tools
    vim

    # Prompt
    pure-prompt

    # Programming languages
    nodejs_23
    rustup
    nixd
    go
    gopls
    gotools
    templ
    typst
    tinymist

    # Programming cli
    pnpm
    wgo

    # CLI tools

    # General
    btop
    fastfetch
    bat
    ripgrep
    libwebp

    # Git
    gh
    lazygit

    # TUI Apps
    circumflex

    # Encryption
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
    caskArgs.require_sha = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    casks = [
      "firefox"
      "visual-studio-code"
      "kitty"
      "discord"
      "iina"
      "alt-tab"
      "tailscale"
      "altserver"
      "transmission"
      "jordanbaird-ice"
      "orbstack"
      "whisky"
    ];
    masApps = {
      "Amphetamine" = 937984704;
      "Klack" = 6446206067;
    };
  };
}

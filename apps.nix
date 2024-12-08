{ pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Development tools
    vim
    helix

    # Prompt
    pure-prompt

    # Programming languages
    nodejs_23
    nil
    nixd
    nixfmt-rfc-style
    go
    gopls
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

    # File manager
    yazi

    # Encryption
    age
  ];

  environment.variables.EDITOR = "nvim";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    casks = [
      "hammerspoon"
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
      "halloy"
      "figma"
    ];
    masApps = {
      "Amphetamine" = 937984704;
      "Klack" = 6446206067;
    };
  };
}

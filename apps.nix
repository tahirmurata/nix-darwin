{ pkgs, ... }:

{
  # Environment Configuration
  environment = {
    systemPackages = with pkgs; [
      # Development Tools
      ## Text Editors & IDEs
      helix # Modern modal text editor

      ## Version Control
      gh # GitHub command line interface
      lazygit # Terminal UI for git

      ## Programming Languages
      go # Go programming language
      gopls # Go language server
      gotools # Go development utilities
      nodejs_23 # JavaScript runtime environment
      pnpm # Fast and efficient JavaScript package manager

      ## Nix Tools
      nixd # Nix language server
      nixfmt-rfc-style # Nix code formatter
      devenv # Declarative development environments

      ## Document Processing
      typst # Modern markup-based typesetting system
      tinymist # Language service for Typst

      # System Utilities
      ## Monitoring & System Tools
      btop # System resource monitor
      fastfetch # System information display tool
      wgo # Go live reload utility
      age # Modern file encryption tool

      ## File Management
      yazi # Fast terminal file manager

      # Applications
      vscode # Microsoft's open source code editor
      iina # Modern media player for macOS
      tailscale # Mesh VPN built on WireGuard
      alt-tab-macos # Windows alt-tab on macOS
      transmission_4 # BitTorrent client

      # Shell
      pure-prompt # Minimal and fast ZSH prompt
    ];

    variables = {
      EDITOR = "hx";

      # Homebrew Configuration
      HOMEBREW_NO_ANALYTICS = "1";
      HOMEBREW_NO_INSECURE_REDIRECT = "1";
      HOMEBREW_NO_EMOJI = "1";
      HOMEBREW_NO_ENV_HINTS = "0";
    };
  };

  # Homebrew Configuration
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    # Application Installations
    casks = [
      "firefox" # Open-source web browser
      "google-chrome" # Web browser with Chromecast support
      "ghostty@tip" # GPU-accelerated terminal emulator
      "orbstack" # Docker and Linux container manager
      "altserver" # iOS sideloading utility
      "krita" # Open-source digital art program
    ];

    masApps = {
      "Amphetamine" = 937984704; # Powerful keep-awake utility
      "Klack" = 6446206067; # Satisfying sound with every keystroke.
    };
  };
}

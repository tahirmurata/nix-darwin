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
      jujutsu # A Git-compatible VCS that is both simple and powerful

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
      "visual-studio-code" # Open-source code editor
      "iina" # Free and open-source media player
      "tailscale" # Mesh VPN based on WireGuard
      "alt-tab" # Enable Windows-like alt-tab
      "transmission" # Open-source BitTorrent client
      "ghostty" # Terminal emulator that uses platform-native UI and GPU acceleration
      "firefox" # Open-source web browser
      "google-chrome" # Web browser with Chromecast support
      "orbstack" # Docker and Linux container manager
      "altserver" # iOS sideloading utility
      "krita" # Open-source digital art program
      "figma" # Collaborative team software
    ];

    masApps = {
      "Amphetamine" = 937984704; # Powerful keep-awake utility
      "Klack" = 6446206067; # Satisfying sound with every keystroke.
    };
  };
}

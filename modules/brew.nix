{ me, ... }:
{
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = me.username;
  };

  # Environment Variables
  environment.variables = {
    # Homebrew Configuration
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_INSECURE_REDIRECT = "1";
    HOMEBREW_NO_EMOJI = "1";
    HOMEBREW_NO_ENV_HINTS = "1";
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
      "google-chrome" # Web browser with Chromecast support
      "orbstack" # Docker and Linux container manager
      "altserver" # iOS sideloading utility
      "krita" # Open-source digital art program
      "figma" # Collaborative team software
      "livebook" # Code notebooks for Elixir developers
      "jetbrains-toolbox" # JetBrains tools manager
      "keka" # The macOS file archiver
      "thorium" # Epub reader
    ];

    masApps = {
      "Amphetamine" = 937984704; # Powerful keep-awake utility
      "Klack" = 6446206067; # Satisfying sound with every keystroke.
    };
  };
}

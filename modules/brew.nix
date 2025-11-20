{ me, ... }:
{
  nix-homebrew = {
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = me.user;

    # Disable adding taps imperatively with `brew tap`
    mutableTaps = false;
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

    casks = [
      "visual-studio-code"
      "iina"
      "alt-tab"
      "transmission"
      "orbstack"
      "altserver"
      "keka"
      "google-chrome"
      "firefox@developer-edition"
      "kitty"
      "linkliar"
      "ghostty"
    ];

    masApps = {
      "Amphetamine" = 937984704;
      "Klack" = 6446206067; 
    };
  };
}

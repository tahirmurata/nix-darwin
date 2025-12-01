# Any copyright is dedicated to the Public Domain.
# https://creativecommons.org/publicdomain/zero/1.0/

{ me, inputs, ... }:
{
  nix-homebrew = {
    enable = true;
    enableRosetta = true;

    user = me.user;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false;
  };

  environment.variables = {
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_INSECURE_REDIRECT = "1";
    HOMEBREW_NO_EMOJI = "1";
    HOMEBREW_NO_ENV_HINTS = "1";
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    casks = [
      "visual-studio-code"
      "zed"
      "iina"
      "alt-tab"
      "transmission"
      "orbstack"
      "altserver"
      "keka"
      "google-chrome"
      "firefox@developer-edition"
      "linkliar"
      "ghostty"
    ];

    masApps = {
      "Amphetamine" = 937984704;
      "Klack" = 6446206067;
    };
  };
}

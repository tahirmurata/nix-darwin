# Any copyright is dedicated to the Public Domain.
# https://creativecommons.org/publicdomain/zero/1.0/

{ me, inputs, ... }:
{
  nix-homebrew = {
    enable = true;

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
      "firefox"
      "discord"
      "google-chrome"
      "iina"
      "jetbrains-toolbox"
      "keka"
      "kitty"
      "linkliar"
      "logseq"
      "orbstack"
      "transmission"
      "visual-studio-code"
    ];

    masApps = {
      "Amphetamine" = 937984704;
      "uBlock Origin Lite" = 6745342698;
    };
  };
}

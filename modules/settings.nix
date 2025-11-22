# Any copyright is dedicated to the Public Domain.
# https://creativecommons.org/publicdomain/zero/1.0/

{ ... }:
{
  nix = {
    enable = true;

    settings = {
      trusted-users = [
        "@admin"
      ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Runs during build
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };
}

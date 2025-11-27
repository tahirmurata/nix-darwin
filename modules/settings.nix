# Any copyright is dedicated to the Public Domain.
# https://creativecommons.org/publicdomain/zero/1.0/

{ pkgs, ... }:
{
  nix = {
    enable = true;

    linux-builder = {
      enable = true;
      package = pkgs.darwin.linux-builder-x86_64;
      ephemeral = true;
      config = {
        virtualisation = {
          darwin-builder = {
            diskSize = 40 * 1024;
            memorySize = 8 * 1024;
          };
          cores = 6;
        };
      };
    };

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

{ pkgs, ... }:
{
  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    enable = true;

    settings = {
      # Set user as trusted
      trusted-users = [
        "@admin"
      ];
      # Necessary for using flakes on this system
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Optimize store during build
      auto-optimise-store = true;
    };

    # Automatically run garbage collection
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

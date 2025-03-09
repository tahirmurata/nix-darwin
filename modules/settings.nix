{ ... }:
{
  nix = {
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
    };

    # Automatically run garbage collection
    gc = {
      automatic = true;
      interval = [
        {
          Hour = 12;
          Minute = 0;
          Weekday = 6;
        }
      ];
    };
  };
}

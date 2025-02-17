{ me, ... }:
{
  nix = {
    settings = {
      # Set user as trusted
      trusted-users = [
        "root"
        me.username
      ];
      # Necessary for using flakes on this system
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Cache for flox
      substituters = [
        "https://cache.flox.dev"
      ];
      trusted-public-keys = [
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
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

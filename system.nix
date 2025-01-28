{ config, pkgs, ... }:

###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#
###################################################################################
{
  # power = {
  #   sleep = {
  #     display = "never"; # Never turn off the display
  #     computer = "never"; # Never put the computer to sleep
  #   };
  # };

  system = {
    stateVersion = 5;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true; # Show 24 hour clock

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark"; # Set dark mode
        ApplePressAndHoldEnabled = false; # Disable accented characters
        InitialKeyRepeat = 15; # Set initial key repeat delay
        KeyRepeat = 2; # Set key repeat rate
        AppleShowScrollBars = "Always"; # Always show scrollbars
      };

      finder = {
        NewWindowTarget = "Home"; # Open new Finder windows in Computer
        AppleShowAllExtensions = true; # Show all file extensions
        AppleShowAllFiles = true; # Show hidden files by default
        ShowStatusBar = true; # Show status bar
        ShowPathbar = true; # Show path bar
        _FXShowPosixPathInTitle = true; # Show full path in Finder title
        _FXSortFoldersFirst = true; # Sort folders first
        FXDefaultSearchScope = "SCcf"; # Search the current folder by default
        FXEnableExtensionChangeWarning = false; # Disable extension change warning
        FXPreferredViewStyle = "Nlsv"; # Set default view to list
      };

      dock = {
        tilesize = 64; # Set the dock tile size

        # Set the dock to autohide and remove the delay
        launchanim = false;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        autohide = true;

        mru-spaces = false; # Disable most recent spaces

        showhidden = true; # Show hidden apps in the dock

        show-recents = false; # Remove recent apps from the dock

        # Hot corners
        wvous-tr-corner = 13; # top right corner
        wvous-tl-corner = 1; # top left corner
        wvous-br-corner = 1; # bottom right corner
        wvous-bl-corner = 1; # bottom left corner

        persistent-apps = [
          "/System/Applications/System Settings.app"
          "/Applications/Firefox.app"
          "/Applications/kitty.app"
          "/System/Applications/Music.app"  
        ];
        persistent-others = null;
      };

      trackpad = {
        Clicking = true; # Enable tap to click
        TrackpadRightClick = true; # Enable right click
      };

      ActivityMonitor = {
        ShowCategory = 100; # Show all processes
        SortColumn = "CPUUsage"; # Sort by CPU usage
        SortDirection = 0; # Sort in descending order
      };

      screensaver = {
        askForPassword = true; # Ask for password immediately after sleep or screen saver begins
        askForPasswordDelay = 0; # Set the delay to 0
      };

      WindowManager = {
        EnableStandardClickToShowDesktop = false; # Disable click on the wallpaper to show desktop
        StandardHideDesktopIcons = true; # Hide desktop icons
      };

      # remember to set the hostname in the kernel command line
      smb.NetBIOSName = config.networking.hostName;
    };
  };
  # Add ability to use TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
    
      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      pkgs.nerd-fonts.symbols-only
    ];
  };
}

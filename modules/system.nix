# Any copyright is dedicated to the Public Domain.
# https://creativecommons.org/publicdomain/zero/1.0/

{ inputs, me, ... }:
{
  time.timeZone = "Asia/Tokyo";

  networking = {
    applicationFirewall.enable = true;
    applicationFirewall.enableStealthMode = true;
    applicationFirewall.allowSigned = true;
    applicationFirewall.allowSignedApp = true;
  };

  system = {
    primaryUser = me.user;

    # Nix state version
    stateVersion = 6;

    # Set Git commit hash for darwin-version
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true; # Show 24 hour clock

      hitoolbox.AppleFnUsageType = "Do Nothing";

      loginwindow = {
        DisableConsoleAccess = false;
        GuestEnabled = false;
        LoginwindowText = null;
        SHOWFULLNAME = true;
        # TODO: Add option to remove username and profile picture.
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark"; # Set dark mode
        ApplePressAndHoldEnabled = false; # Disable accented characters
        InitialKeyRepeat = 15; # Set initial key repeat delay
        KeyRepeat = 2; # Set key repeat rate
        AppleShowScrollBars = "Always"; # Always show scrollbars

        # Several spelling related settings
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        # Use expanded save panel by default
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
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

        # Dock apps
        persistent-apps = [
          { app = "/System/Applications/System Settings.app"; }
          { app = "/Applications/Firefox Developer Edition.app"; }
          { app = "/Applications/kitty.app"; }
          { app = "/System/Applications/Music.app"; }
        ];
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
        EnableTiledWindowMargins = false; # Disable window margins when tiling windows
        EnableTilingByEdgeDrag = true; # Disable draggin windows to screen edges to tile them
        EnableTilingOptionAccelerator = false; # Disable holding alt to tile windows
        EnableTopTilingByEdgeDrag = true; # Disable dragging windows to the menu bar to fill the screen
      };

      CustomUserPreferences = {
        # Disable siri
        "com.apple.Siri" = {
          "UAProfileCheckingStatus" = 0;
          "siriEnabled" = 0;
        };
        # Disable personalized ads
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
      };
    };
  };

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";

    DO_NOT_TRACK = "1";
  };

  # Add ability to use TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # This is required if you want to use darwin's default shell - zsh
  programs.zsh = {
    enable = true;
    shellInit = # zsh
      ''
        if [ -n "''\${GHOSTTY_RESOURCES_DIR}" ]; then
          exec fish
        fi
      '';
  };

  # Disable history for bash.
  # This is due to fish automatically importing `.bash_history`.
  programs.bash = {
    enable = true;
    interactiveShellInit = # bash
      ''
        unset HISTFILE
      '';
  };

  services.openssh.enable = true;

  programs.fish.enable = true;

  users.users.${me.user} = {
    home = "/Users/${me.user}";
  };
}

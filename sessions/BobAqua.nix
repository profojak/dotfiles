{ pkgs, inputs, ... }:
let
  appearance.defaults = {
    NSGlobalDomain = {
      # Set to dark mode, do not switch to light mode.
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      # Show all file extensions, and hidden files.
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      # Show scroll bars only when scrolling.
      AppleShowScrollBars = "WhenScrolling";
      # Scroll smoothly when using keyboard.
      NSScrollAnimationEnabled = true;
      # Do not hide menu bar.
      _HIHideMenuBar = false;
    };
    dock = {
      # Group windows by application in mission control.
      expose-group-apps = true;
      # Set dock to bottom, and size of icons.
      orientation = "bottom";
      tilesize = 40;
      # Automatically hide and show dock.
      autohide = true;
      # Animate opening applications from dock.
      launchanim = true;
      # Minimize window with scale effect, and into application icon in dock.
      mineffect = "scale";
      minimize-to-application = true;
      # Show process indicators for open applications in dock.
      show-process-indicators = true;
      # Do not show recent applications in dock.
      show-recents = false;
    };
    menuExtraClock = {
      # Do show seconds, do not flash clock each second.
      ShowSeconds = false;
      FlashDateSeparators = false;
      # Show digital clock in 24-hour format.
      IsAnalog = false;
      Show24Hour = false;
      ShowAMPM = false;
      # Do not anything else except time.
      ShowDate = 2;
      ShowDayOfMonth = false;
      ShowDayOfWeek = false;
    };
  };

  window.defaults = {
    dock = {
      # Set bottom left hot corner action to open quick note.
      wvous-bl-corner = 14;
      # Set top left hot corner action to open launchpad.
      wvous-tl-corner = 11;
      # Disable bottom right and top right hot corner action.
      wvous-br-corner = 1;
      wvous-tr-corner = 1;
      # Rearrange spaces based on most recent use.
      mru-spaces = true;
    };
    # Use separate space for each display.
    spaces.spans-displays = false;
    NSGlobalDomain = {
      # Switch to pace with open application window.
      AppleSpacesSwitchOnActivate = true;
      # Prefer fullscreen tab when opening new document.
      AppleWindowTabbingMode = "fullscreen";
      # Show expanded panel in save dialogs.
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };
    WindowManager = {
      # Show all windows of application at once.
      AppWindowGroupingBehavior = true;
      # Do not show recent apps in stage manager.
      AutoHide = true;
      # Click wallpaper to reveal desktop only in stage manager.
      EnableStandardClickToShowDesktop = false;
      # Enable window margins when tiling.
      EnableTiledWindowMargins = true;
      # Enable tiling by dragging to screen edges, and by holding ⌥ key.
      EnableTilingByEdgeDrag = true;
      EnableTilingOptionAccelerator = true;
      # Drag to menu bar to fill screen.
      EnableTopTilingByEdgeDrag = true;
      # Hide items and widgets in stage manager and on desktop.
      HideDesktop = true;
      StageManagerHideWidgets = true;
      StandardHideDesktopIcons = true;
      StandardHideWidgets = true;
    };
  };

  mouse.defaults = {
    # Set mouse and trackpad tracking speed to ⅓ of slider.
    ".GlobalPreferences"."com.apple.mouse.scaling" = 0.6875;
    NSGlobalDomain."com.apple.trackpad.scaling" = 0.6875;
    # Enable trackpad force click.
    NSGlobalDomain."com.apple.trackpad.forceClick" = true;
    trackpad = {
      # Disable tap to click, and tap to drag.
      Clicking = false;
      Dragging = false;
      # Make clicks light.
      FirstClickThreshold = 0;
      SecondClickThreshold = 0;
      # Enable right click.
      TrackpadRightClick = true;
      # Disable three finger drag, and tap gesture.
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerTapGesture = 0;
    };
    NSGlobalDomain = {
      # Enable swiping left or right with two fingers to navigate backward or forward.
      AppleEnableMouseSwipeNavigateWithScrolls = true;
      AppleEnableSwipeNavigateWithScrolls = true;
      # Jump to spot that is clicked on scroll bar, and scroll in natural scrolling direction.
      AppleScrollerPagingBehavior = true;
      "com.apple.swipescrolldirection" = true;
      # Enable spring loading, and set spring loading delay to right of slider.
      "com.apple.springing.enabled" = true;
      "com.apple.springing.delay" = 0.0;
    };
  };

  keyboard = {
    defaults = {
      NSGlobalDomain = {
        # Set key repeat rate, and delay until repeat.
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        # Disable automatic capitalization, and disable period with double-space.
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        # Show inline predictive text, and disable automatic spelling correction.
        NSAutomaticInlinePredictionEnabled = true;
        NSAutomaticSpellingCorrectionEnabled = false;
        # Use function keys as standard function keys.
        "com.apple.keyboard.fnState" = true;
      };
      # Press fn key to show emoji and symbols.
      hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";
    };
    keyboard = {
      # Remap caps lock to escape.
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  sound = {
    defaults = {
      NSGlobalDomain = {
        # Disable feedback sound when changing volume.
        "com.apple.sound.beep.feedback" = 0;
        # Set alert volume to ½ of slider.
        "com.apple.sound.beep.volume" = 0.6065307;
      };
    };
    # Disable sound on startup.
    startup.chime = false;
  };

  measurementUnit.defaults = {
    NSGlobalDomain = {
      # Use 24-hour time format.
      AppleICUForce24HourTime = true;
      # Use metric system.
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      # Use Celsius.
      AppleTemperatureUnit = "Celsius";
    };
  };

  activityMonitor.defaults = {
    ActivityMonitor = {
      OpenMainWindow = true;
      # Change dock icon to application icon.
      IconType = 0;
      # Show all processes.
      ShowCategory = 100;
    };
  };

  calendar.defaults = {
    iCal = {
      "first day of week" = "Monday";
      "TimeZone support enabled" = true;
      # Show calendar sidebar.
      CalendarSidebarShown = true;
    };
  };

  finder.defaults = {
    finder = {
      # Show path bar, do not show status bar.
      ShowPathbar = true;
      ShowStatusBar = false;
      # Open in column view, and in home folder.
      FXPreferredViewStyle = "clmv";
      NewWindowTarget = "Home";
      # Search current folder when searching.
      FXDefaultSearchScope = "SCcf";
      # Keep folders on top when sorting by name.
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
      # Show all file extensions, and hidden files.
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      # Do not show anything on desktop.
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
      # Remove trash items after 30 days.
      FXRemoveOldTrashItems = true;
    };
  };
in
{
  time.timeZone = "Europe/Prague";
  system = pkgs.lib.mkMerge [
    appearance
    window
    mouse
    keyboard
    sound
    measurementUnit
    activityMonitor
    calendar
    finder
  ];
}

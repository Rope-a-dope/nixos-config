{ inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

  # Start Noctalia only inside a Niri session, not COSMIC.
  systemd.user.services.noctalia.Service.ExecCondition =
    "${pkgs.writeShellScript "noctalia-niri-only" ''
      test \"''${XDG_CURRENT_DESKTOP:-}\" = \"niri\" ||
      test \"''${XDG_CURRENT_DESKTOP:-}\" = \"Niri\"
    ''}";

  home.packages = [
    pkgs.fuzzel
    pkgs.wezterm
    inputs.herdr-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.symbols-only
    pkgs.symbola
  ];

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;

  # Manage all Fcitx5 themes from the repository.
  xdg.dataFile."fcitx5/themes".source =
    ./files/fcitx5/themes;

  # Manage Classic UI settings, preserving existing preferences.
  xdg.configFile."fcitx5/conf/classicui.conf" = {
  force = true;
  text = ''
    # Vertical Candidate List
    Vertical Candidate List=False
    # Use mouse wheel to go to prev or next page
    WheelForPaging=True
    # Font
    Font="Sans 16"
    # Menu Font
    MenuFont="Sans 16"
    # Tray Font
    TrayFont="Sans Bold 16"
    # Tray Label Outline Color
    TrayOutlineColor=#000000
    # Tray Label Text Color
    TrayTextColor=#ffffff
    # Prefer Text Icon
    PreferTextIcon=False
    # Show Layout Name In Icon
    ShowLayoutNameInIcon=True
    # Use input method language to display text
    UseInputMethodLanguageToDisplayText=True
    # Theme
    Theme=lost-temple
    # Dark Theme
    DarkTheme=lost-temple
    # Follow system light/dark color scheme
    UseDarkTheme=False
    # Follow system accent color if it is supported by theme and desktop
    UseAccentColor=True
    # Use Per Screen DPI on X11
    PerScreenDPI=False
    # Force font DPI on Wayland
    ForceWaylandDPI=0
    # Enable fractional scale under Wayland
    EnableFractionalScale=True
  '';
  };
}

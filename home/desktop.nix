
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
    inputs.herdr-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

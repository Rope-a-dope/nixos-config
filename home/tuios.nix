{ inputs, pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs-unstable.tuios
  ];

  xdg.configFile."tuios/config.toml".source =
    ./files/tuios/config.toml;
}

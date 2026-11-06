{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.tuios.packages.${pkgs.stdenv.hostPlatform.system}.tuios
  ];

  xdg.configFile."tuios/config.toml".source =
    ./files/tuios/config.toml;
}

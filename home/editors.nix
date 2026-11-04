{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Neovim configuration
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/nvim";

  # Kakoune configuration
  xdg.configFile."kak".source = pkgs.runCommand "kak-config" { } ''
    cp -r ${./kak}/. $out
    chmod -R u+w $out
    ln -s ${pkgs.kakoune}/share/kak/autoload/rc $out/autoload/rc
  '';

  xdg.configFile."kak-tree-sitter/config.toml".source = ./kak-tree-sitter/config.toml;

  home.packages = [
    inputs.popup-kak.packages.${pkgs.stdenv.hostPlatform.system}.default

    (pkgs.kakoune-lsp.overrideAttrs (_: rec {
      version = "22.0.0";

      src = pkgs.fetchFromGitHub {
        owner = "kakoune-lsp";
        repo = "kakoune-lsp";
        tag = "v${version}";
        hash = "sha256-G4L9FOS097U7pLpYTnsUF0FK7UjQ9oQRTtH0ifsL5Ks=";
      };

      cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-QL2uE0hZtrZFJm3KpnTDXACjPY4gNefP76QjD0ZOLMo=";
      };
    }))
  ];
}

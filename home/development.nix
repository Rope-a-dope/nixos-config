{ config, pkgs, inputs, ... }:
{
  xdg.configFile."doom".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nixos-config/doom";

  xdg.configFile."kak".source = ./kak;

  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    defaultEditor = true;
    client.enable = true;
  };

  programs.fish.interactiveShellInit = ''
    fish_add_path $HOME/.config/emacs/bin
  '';

  home.packages = with pkgs; [
    inputs.popup-kak.packages.${pkgs.stdenv.hostPlatform.system}.default

    gcc
    gnumake
    tree-sitter
    stylua
    lazygit
    inputs.tuios.packages.${pkgs.stdenv.hostPlatform.system}.tuios
    lua-language-server
    kakoune-lsp

    emacs-pgtk
    discount
    shellcheck
    unzip
    wget

    beam29Packages.erlang
    beam29Packages.elixir_1_20
    (beam29Packages.elixir-ls.override {
      elixir = beam29Packages.elixir_1_20;
    })
    beam29Packages.hex
    beam29Packages.rebar3

    inotify-tools
    nodejs
  ];
}

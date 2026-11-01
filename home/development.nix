{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./claude-code.nix
  ];

  xdg.configFile."doom".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/doom";

  xdg.configFile."kak".source = pkgs.runCommand "kak-config" { } ''
    cp -r ${./kak}/. $out
    chmod -R u+w $out
    ln -s ${pkgs.kakoune}/share/kak/autoload/rc $out/autoload/rc
  '';

  xdg.configFile."kak-tree-sitter/config.toml".source =
    ./kak-tree-sitter/config.toml;

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

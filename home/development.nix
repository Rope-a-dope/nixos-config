{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./claude-code.nix
  ];

  xdg.configFile."doom".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/doom";

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
    gcc
    gnumake
    tree-sitter
    nil
    rust-analyzer
    nixfmt
    rustfmt
    stylua
    lazygit
    lua-language-server
    tailwindcss-language-server

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
    kakounePlugins.hop-kak
  ];
}

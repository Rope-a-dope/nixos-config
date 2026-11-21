{
  config,
  pkgs,
  pkgs-unstable,
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

  home.packages =
    (with pkgs; [
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

      inotify-tools
      nodejs
      kakounePlugins.hop-kak
    ])
    ++ (with pkgs-unstable.beam29Packages; [
      erlang
      elixir_1_20
      (elixir-ls.override {
        elixir = elixir_1_20;
      })
      hex
      rebar3
    ]);
}

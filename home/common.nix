{ config, pkgs, inputs, ... }:

{
  home.username = "smallv";
  home.homeDirectory = "/home/smallv";
  home.stateVersion = "26.05";

  xdg.configFile."cosmic/com.system76.CosmicComp/v1/keyboard_config".text = ''
    (
      numlock_state: BootOn,
    )
  '';

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;

  xdg.configFile."starship.toml".source = ./starship.toml;

  xdg.configFile."nvim".source =
  config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-config/home/nvim";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
      fish_add_path $HOME/.config/emacs/bin
    '';
    shellAliases = {
      ll = "eza -lah";
      ls = "eza";
      cat = "bat";
    };
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    bat
    eza
    fd
    fzf
    ripgrep
    gcc
    gnumake
    tree-sitter
    stylua
    lazygit
    inputs.tuios.packages.${pkgs.stdenv.hostPlatform.system}.tuios
    lua-language-server
    wezterm
    emacs
    nerd-fonts.jetbrains-mono
    symbola
    nerd-fonts.symbols-only
    discount
    shellcheck
    unzip
    wget
    beam29Packages.erlang
    beam29Packages.elixir_1_20
    beam29Packages.elixir-ls
    beam29Packages.hex
    beam29Packages.rebar3
    inotify-tools
    podman-compose
    nodejs
  ];
}

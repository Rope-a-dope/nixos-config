{ config, pkgs, inputs, ... }:

{
  home.username = "smallv";
  home.homeDirectory = "/home/smallv";
  home.stateVersion = "26.05";

  xdg.configFile."starship.toml".source = ./starship.toml;

  xdg.configFile."nvim".source =
  config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-config/home/nvim";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
      set -gx EDITOR nvim
      set -gx VISUAL nvim
    '';

    shellAliases = {
      ll = "eza -lah";
      ls = "eza";
      cat = "bat";
      tree = "eza --tree";
      grep = "rg";
      find = "fd";
      mkdir = "mkdir -p";
    };

    shellAbbrs = {
      # Git
      g = "git";
      gs = "git status";
      gd = "git diff";
      ga = "git add";
      gc = "git commit";
      gl = "git log --oneline --graph --decorate";

      # NixOS and Home Manager
      nf = "nix flake";
      nfc = "nix flake check";
      nfu = "nix flake update";

      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      c = "clear";
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

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    bat
    eza
    fd
    fzf
    tmux
    ripgrep
    satty
    ncdu
    dust
    procs
    jq
    yq-go
  ];
}

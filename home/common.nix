{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:

{
  imports = [
    ./yazi
  ];

  home.username = "smallv";
  home.homeDirectory = "/home/smallv";
  home.stateVersion = "26.05";

  xdg.configFile."starship.toml".source = ./starship.toml;

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
    package = pkgs-unstable.atuin;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs-unstable.starship;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.nushell = {
    enable = true;
    package = pkgs-unstable.nushell;
  };

  home.packages =
    (with pkgs; [
      bat
      eza
      fd
      fzf
      tmux
      ripgrep
      dust
      procs
      jq
      yq-go
    ])
    ++ [
      pkgs-unstable.ncdu
    ];
}

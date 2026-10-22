{ pkgs, ... }:

{
  home.username = "smallv";
  home.homeDirectory = "/home/smallv";
  home.stateVersion = "26.05";

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

  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.atuin.enable = true;
  programs.yazi.enable = true;

  home.packages = with pkgs; [
    bat
    eza
    fd
    ripgrep
    wezterm
    emacs
    symbola
    nerd-fonts.symbols-only
    discount
    shellcheck
  ];
}

{ ... }:

{
  flake.nixosModules.sharedPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      gcc
      git
      fastfetch
      flirt
      moreutils
      neovim
      nixfmt
      tree
      tree-sitter
    ];
  };
}

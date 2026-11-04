{ ... }:

{
  flake.nixosModules.sharedPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      gcc
      git
      fastfetch
      neovim
      nixfmt
      tree
      tree-sitter
    ];
  };
}

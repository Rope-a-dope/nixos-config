{ ... }:

{
  flake.nixosModules.sharedPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git
      fastfetch
      tree
      neovim
    ];
  };
}

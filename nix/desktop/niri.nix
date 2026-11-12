{ inputs, ... }:

{
  flake.nixosModules.niriDesktop = { ... }: {
    programs.niri.enable = true;

    home-manager.sharedModules = [
      inputs.voxtype.homeManagerModules.default
    ];
  };
}

{ ... }:

{
  flake.nixosModules.niriDesktop = { ... }: {
    programs.niri.enable = true;
  };
}

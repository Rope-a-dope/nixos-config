{ ... }:

{
  flake.nixosModules.postgresql =
    { inputs, pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      # PostgreSQL 18 is shared by Immich and Paperless.
      services.postgresql.package = unstable.postgresql_18;
    };
}

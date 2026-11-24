{ ... }:

{
  flake.nixosModules.postgresql = { pkgs, ... }: {
    # PostgreSQL 18 is shared by Immich and Paperless.
    services.postgresql.package = pkgs.postgresql_18;
  };
}

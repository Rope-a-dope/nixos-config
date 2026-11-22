{ ... }:

{
  flake.nixosModules.immich =
    { inputs, pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      services.immich = {
        enable = true;
        package = unstable.immich;
        mediaLocation = "/mnt/Backup/Photos/Immich";
        host = "127.0.0.1";
        openFirewall = false;
      };

      # Ensure the external media disk is mounted before Immich starts.
      systemd.services.immich-server = {
        requires = [ "mnt-Backup.mount" ];
        after = [ "mnt-Backup.mount" ];
      };
    };
}

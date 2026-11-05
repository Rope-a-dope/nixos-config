{ ... }:

{
  flake.nixosModules.immich = { inputs, pkgs, ... }: {
    services.immich = {
      enable = true;

      package =
        inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.immich;

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

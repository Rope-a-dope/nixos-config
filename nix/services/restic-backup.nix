{ ... }:

{
  flake.nixosModules.resticBackup = { pkgs, ... }: {
    services.restic.backups.server = {
      package = pkgs.restic;
      user = "root";

      repository = "/mnt/Backup/Backups/Immich";
      passwordFile = "/run/secrets/restic-repository-password";
      initialize = true;

      paths = [
        "/mnt/Backup/Photos/Immich"
        "/var/lib/immich-backup"
        "/mnt/Backup/Documents/Paperless"
        "/var/lib/paperless-backup"
      ];

      backupPrepareCommand = ''
        install -d -o postgres -g postgres -m 0700 /var/lib/immich-backup
        install -d -o postgres -g postgres -m 0700 /var/lib/paperless-backup

        runuser -u postgres -- pg_dump \
          --format=custom \
          immich \
          --file=/var/lib/immich-backup/immich.dump

        runuser -u postgres -- pg_dump \
          --format=custom \
          paperless \
          --file=/var/lib/paperless-backup/paperless.dump
      '';

      backupCleanupCommand = ''
        rm -f /var/lib/immich-backup/immich.dump
        rm -f /var/lib/paperless-backup/paperless.dump
      '';

      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };

    systemd.services.restic-backups-server = {
      requires = [
        "mnt-Backup.mount"
        "postgresql.target"
      ];

      after = [
        "mnt-Backup.mount"
        "postgresql.target"
      ];

      path = [
        pkgs.util-linux
        pkgs.postgresql
        pkgs.coreutils
      ];
    };
  };
}

{ ... }:

{
  flake.nixosModules.paperless = { config, ... }: {
    services.paperless = {
      enable = true;

      address = "127.0.0.1";
      port = 28981;

      dataDir = "/var/lib/paperless";
      mediaDir = "/mnt/Backup/Documents/Paperless/documents";
      consumptionDir = "/mnt/Backup/Documents/Paperless/consume";

      database.createLocally = false;

      environmentFile = config.sops.templates."paperless-environment".path;

      settings = {
        PAPERLESS_DBHOST = "127.0.0.1";
        PAPERLESS_DBNAME = "paperless";
        PAPERLESS_DBUSER = "paperless";
        PAPERLESS_URL = "https://paperless.home.arpa";
        PAPERLESS_TIME_ZONE = "America/Los_Angeles";
      };
    };

    systemd.services.paperless-web= {
      requires = [ "mnt-Backup.mount" ];
      after = [ "mnt-Backup.mount" ];
    };

    systemd.services.paperless-consumer = {
      requires = [ "mnt-Backup.mount" ];
      after = [ "mnt-Backup.mount" ];
    };
  };
}

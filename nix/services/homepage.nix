{ ... }:

{
  flake.nixosModules.homepage = { ... }: {
    services.homepage-dashboard = {
      enable = true;
      listenPort = 3001;
      openFirewall = true;
      allowedHosts = "homepage.home.arpa,192.168.68.133:3001";

      settings = {
        title = "Beelink";
        theme = "dark";
        color = "slate";
        headerStyle = "clean";

        layout = {
          Infrastructure = {
            style = "row";
            columns = 2;
          };
          Media = {
            style = "row";
            columns = 2;
          };
          Documents = {
            style = "row";
            columns = 2;
          };
          Downloads = {
            style = "row";
            columns = 2;
          };
          Synchronization = {
            style = "row";
            columns = 2;
          };
        };
      };

      widgets = [
        {
          resources = {
            label = "System";
            cpu = true;
            memory = true;
            uptime = true;
          };
        }
        {
          resources = {
            label = "Storage";
            expanded = true;
            disk = [
              "/"
              "/mnt/Backup"
              "/mnt/Media"
            ];
          };
        }
      ];

      services = [
        {
          Infrastructure = [
            {
              "AdGuard Home" = {
                href = "https://adguard.home.arpa";
                description = "Network DNS and filtering";
              };
            }
            {
              "Caddy Documentation" = {
                href = "https://caddyserver.com/docs/";
                description = "Reverse proxy documentation";
              };
            }
          ];
        }

        {
          Media = [
            {
              Jellyfin = {
                href = "https://jellyfin.home.arpa";
                description = "Movies and TV";
              };
            }
            {
              Immich = {
                href = "https://immich.home.arpa";
                description = "Photo and video library";
              };
            }
          ];
        }

        {
          Documents = [
            {
              Paperless = {
                href = "https://paperless.home.arpa";
                description = "Document management";
              };
            }
          ];
        }

        {
          Downloads = [
            {
              qBittorrent = {
                href = "https://qbittorrent.home.arpa";
                description = "Download management";
              };
            }
          ];
        }

        {
          Synchronization = [
            {
              Syncthing = {
                href = "https://syncthing.home.arpa";
                description = "File synchronization";
              };
            }
          ];
        }
      ];
    };
  };
}

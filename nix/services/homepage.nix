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
        description = "Home server · services and storage";

        theme = "dark";
        color = "slate";
        headerStyle = "clean";
        iconStyle = "theme";
        cardStyle = "hairline";
        blockStyle = "refined";
        font = "plexData";
        useEqualHeights = true;

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

      customCSS = ''
        :root {
          --ef-bg: #272e33;
          --ef-surface: #2e383c;
          --ef-surface-hover: #374145;
          --ef-surface-inner: #232a2e;
          --ef-border: #414b50;

          --ef-text: #d3c6aa;
          --ef-muted: #9da9a0;

          --ef-green: #a7c080;
          --ef-aqua: #83c092;
          --ef-yellow: #dbbc7f;
          --ef-orange: #e69875;
          --ef-red: #e67e80;
        }

        /* Base background */
        html, body, #__next, #page_container {
          background-color: var(--ef-bg) !important;
          color: var(--ef-text) !important;
        }

        /* Top widget bar (System & Storage) */
        #information-widgets,
        .widget-container {
          background-color: var(--ef-surface-inner) !important;
          border-color: var(--ef-border) !important;
        }

        /* Section Headings */
        h2, h3, .group-title {
          color: var(--ef-green) !important;
        }

        /* Service Cards */
        .service-item,
        [class*="ServiceCard_card"] {
          background-color: var(--ef-surface) !important;
          border: 1px solid var(--ef-border) !important;
          box-shadow: none !important;
          transition: background-color 160ms ease, border-color 160ms ease, transform 160ms ease;
        }

        .service-item:hover,
        [class*="ServiceCard_card"]:hover {
          background-color: var(--ef-surface-hover) !important;
          border-color: var(--ef-green) !important;
          transform: translateY(-2px);
        }

        /* Titles, Descriptions & Icons */
        .service-item span,
        .service-item p,
        [class*="ServiceCard_title"] {
          color: var(--ef-text) !important;
        }

        .service-item p[class*="description"],
        [class*="ServiceCard_description"] {
          color: var(--ef-muted) !important;
        }

        .service-item svg,
        [class*="ServiceCard_icon"] {
          color: var(--ef-green) !important;
          fill: var(--ef-green) !important;
        }

        /* Storage / CPU Progress Bars */
        .bg-opacity-20,
        [class*="progress"] {
          background-color: var(--ef-surface-inner) !important;
        }

        [class*="progress"] > div,
        .bg-indigo-500, .bg-blue-500, .bg-emerald-500 {
          background-color: var(--ef-green) !important;
        }
      '';

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
                icon = "mdi-shield-check-outline";
                href = "https://adguard.home.arpa";
                description = "Network DNS and filtering";
              };
            }
            {
              "Caddy Documentation" = {
                icon = "mdi-server-network";
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
                icon = "mdi-play-box-multiple";
                href = "https://jellyfin.home.arpa";
                description = "Movies and TV";
              };
            }
            {
              Immich = {
                icon = "mdi-image-multiple";
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
                icon = "mdi-file-document-multiple";
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
                icon = "mdi-download";
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
                icon = "mdi-sync";
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

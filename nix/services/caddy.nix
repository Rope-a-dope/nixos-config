{ ... }:

{
  flake.nixosModules.caddy = { ... }: {
    services.caddy = {
      enable = true;
      user = "caddy";
      group = "caddy";
      dataDir = "/var/lib/caddy";

      extraConfig = ''
        adguard.home.arpa {
          bind 192.168.68.133
          tls internal
          reverse_proxy 127.0.0.1:3000
        }

        immich.home.arpa {
          bind 192.168.68.133
          tls internal
          reverse_proxy 127.0.0.1:2283
        }

        jellyfin.home.arpa {
          bind 192.168.68.133
          tls internal
          reverse_proxy 127.0.0.1:8096
        }

        paperless.home.arpa {
          bind 192.168.68.133
          tls internal
          reverse_proxy 127.0.0.1:28981
        }

        qbittorrent.home.arpa {
          bind 192.168.68.133
          tls internal
          reverse_proxy 127.0.0.1:8080
        }

        syncthing.home.arpa {
          bind 192.168.68.133
          tls internal
          reverse_proxy 127.0.0.1:8384 {
            header_up Host localhost
          }
        }
      '';
    };

    users.groups.caddy = { };

    users.users.caddy = {
      isSystemUser = true;
      group = "caddy";
      home = "/var/lib/caddy";
      createHome = true;
    };

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}

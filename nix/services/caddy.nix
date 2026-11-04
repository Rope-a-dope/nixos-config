{ ... }:

{
  flake.nixosModules.caddy = { ... }: {
    services.caddy = {
      enable = true;
      user = "caddy";
      group = "caddy";
      dataDir = "/var/lib/caddy";

      extraConfig = ''
        jellyfin.home.arpa {
          tls internal
          reverse_proxy 127.0.0.1:8096
        }

        qbittorrent.home.arpa {
          tls internal
          reverse_proxy 127.0.0.1:8080
        }

        adguard.home.arpa {
          tls internal
          reverse_proxy 127.0.0.1:3000
        }

        syncthing.home.arpa {
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

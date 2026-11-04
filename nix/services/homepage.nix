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
      };

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
              Caddy = {
                href = "https://caddyserver.com";
                description = "Reverse proxy";
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
          ];
        }
      ];
    };
  };
}

{ ... }:

{
  flake.nixosModules.qbittorrent = { ... }: {
    services.qbittorrent = {
      enable = true;
      webuiPort = 8080;
      torrentingPort = 6881;
      openFirewall = false;

      extraArgs = [
        "--confirm-legal-notice"
      ];
    };

    networking.firewall = {
      allowedTCPPorts = [ 6881 ];
      allowedUDPPorts = [ 6881 ];
    };
  };
}

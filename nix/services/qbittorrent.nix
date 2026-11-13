{ ... }:

{
  flake.nixosModules.qbittorrent = { ... }: {
    services.qbittorrent = {
      enable = true;
      webuiPort = 8080;
      torrentingPort = 49160;
      openFirewall = false;

      extraArgs = [
        "--confirm-legal-notice"
      ];
    };

    networking.firewall = {
      allowedTCPPorts = [ 49160 ];
      allowedUDPPorts = [ 49160 ];
    };
  };
}

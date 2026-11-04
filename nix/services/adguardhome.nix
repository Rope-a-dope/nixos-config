{ lib, ... }:

{
  flake.nixosModules.adguardhome = { ... }: {
    users.groups.adguardhome = {};

    users.users.adguardhome = {
      isSystemUser = true;
      group = "adguardhome";
    };

    services.adguardhome = {
      enable = true;
      openFirewall = true;
      mutableSettings = true;
    };

    systemd.services.adguardhome.serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "adguardhome";
      Group = "adguardhome";
    };

    networking.firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };
}

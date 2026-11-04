{ ... }:

{
  flake.nixosModules.jellyfin = { pkgs, ... }: {
    services.jellyfin = {
      enable = true;
      openFirewall = true;

      user = "jellyfin";
      group = "jellyfin";

      hardwareAcceleration = {
        enable = true;
        type = "vaapi";
        device = "/dev/dri/renderD128";
      };
    };

    hardware.graphics = {
      enable = true;
      extraPackages = [
        pkgs.intel-media-driver
      ];
    };

    users.users.jellyfin.extraGroups = [
      "video"
      "render"
    ];
  };
}

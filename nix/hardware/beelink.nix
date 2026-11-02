{ ... }:

{
  flake.nixosModules.beelinkHardware =
    { pkgs, ... }:

    {
      imports = [
        ../_unimported/beelink-hardware.nix
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.configurationLimit = 5;

      swapDevices = [
        {
          device = "/swapfile";
          size = 16 * 1024;
        }
      ];

      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
        ];
      };
    };
}

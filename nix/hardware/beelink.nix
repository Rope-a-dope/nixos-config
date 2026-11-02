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

      fileSystems."/mnt/Backup" = {
        device = "/dev/disk/by-uuid/8408e456-a2ef-4d59-9164-64e22e146cbf";
        fsType = "ext4";
        options = [ "nofail" ];
      };

      fileSystems."/mnt/Media" = {
        device = "/dev/disk/by-uuid/88aee508-87e1-4985-a2f6-a02d5cd46f0b";
        fsType = "ext4";
        options = [ "nofail" ];
      };
    };
}

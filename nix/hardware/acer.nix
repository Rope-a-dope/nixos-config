{ ... }:

{
  flake.nixosModules.acerHardware =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    {
      imports = [
        ../_unimported/acer-hardware.nix
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;

      swapDevices = [
        {
          device = "/swapfile";
          size = 16 * 1024;
        }
      ];

      nixpkgs.config.allowUnfree = true;

      hardware.graphics.enable = true;

      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        branch = "legacy_580";
        open = false;
        modesetting.enable = true;
      };

      fileSystems."/mnt/smallv" = {
        device = "/dev/disk/by-uuid/02510a50-01b0-462c-a1a3-736a40674b5e";
        fsType = "ext4";
        options = [ "nofail" ];
      };
    };
}

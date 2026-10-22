{ ... }:

{
  flake.nixosModules.acerHardware =
    { config, lib, pkgs, ... }:

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
    };
}

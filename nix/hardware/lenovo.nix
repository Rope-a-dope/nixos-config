{ ... }:

{
  flake.nixosModules.lenovoHardware =
    { pkgs, ... }:

    {
      imports = [
        ../_unimported/lenovo-hardware.nix
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      swapDevices = [
        {
          device = "/swapfile";
          size = 8 * 1024;
        }
      ];
    };
}

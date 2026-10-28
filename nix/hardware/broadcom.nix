{ ... }:

{
  flake.nixosModules.broadcomWifi = { config, ... }: {
    hardware.enableRedistributableFirmware = true;

    boot.extraModulePackages = [
      config.boot.kernelPackages.broadcom_sta
    ];

    boot.kernelModules = [ "wl" ];

    boot.blacklistedKernelModules = [
      "b43"
      "bcma"
      "ssb"
    ];
  };
}

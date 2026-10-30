{ ... }:

{
  flake.nixosModules.broadcomWifi = { config, pkgs, ... }: {
    nixpkgs.config.permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-59-6.18.59"
    ];

    hardware.enableRedistributableFirmware = true;

    # BCM43142 Bluetooth firmware
    hardware.firmware = [
      (pkgs.runCommand "broadcom-bt-firmware" {} ''
        mkdir -p $out/lib/firmware/brcm
        cp ${
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/winterheart/broadcom-bt-firmware/master/brcm/BCM43142A0-105b-e065.hcd";
            hash = "sha256-t2eirl1rvQU+UQ3OPwVt9sr5mRic0PqQewQKPQt6/IQ=";
          }
        } $out/lib/firmware/brcm/BCM43142A0-105b-e065.hcd
      '')
    ];

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

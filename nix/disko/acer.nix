{ inputs, lib, ... }:

{
  flake.nixosModules.diskoAcer = {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/ata-INTEL_SSDSC2BB300G4_BTWL436400L9300PGN";

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          root = {
            size = "100%";

            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
    fileSystems."/".device = lib.mkForce "/dev/disk/by-uuid/290bbb3c-7f8e-42e7-8e85-cd7f546fb1c7";

    fileSystems."/boot".device = lib.mkForce "/dev/disk/by-uuid/8DF8-7F21";
  };
}

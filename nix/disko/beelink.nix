{ inputs, lib, ... }:

{
  flake.nixosModules.diskoBeelink = {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/ata-512GB_SSD_MQ21W96201168";

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
    fileSystems."/".device =
      lib.mkForce "/dev/disk/by-uuid/c5a1a9e9-0966-4f8e-b0c5-abec5ecab1a2";

    fileSystems."/boot".device =
      lib.mkForce "/dev/disk/by-uuid/385A-5D73";
  };
}

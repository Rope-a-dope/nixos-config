{ inputs, lib, ... }:

{
  flake.nixosModules.diskoLenovo = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/ata-CT1000MX500SSD1_2105E4F16162";

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
    fileSystems."/".device = lib.mkForce "/dev/disk/by-uuid/b31e58be-4393-468a-b711-84813a0efd3a";

    fileSystems."/boot".device = lib.mkForce "/dev/disk/by-uuid/7216-1DB0";
  };
}

{ ... }:

{
  flake.nixosModules.syncthing = { lib, ... }: {
    services.syncthing = {
      enable = true;
      user = "smallv";
      group = "users";

      dataDir = "/home/smallv";
      configDir = "/home/smallv/.config/syncthing";

      guiAddress = lib.mkDefault "127.0.0.1:8384";

      openDefaultPorts = true;
      overrideDevices = false;
      overrideFolders = false;
    };
  };
}

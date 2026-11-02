{ inputs, ... }:

{
  flake.nixosConfigurations.beelink = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.self.nixosModules.beelinkHardware
      inputs.self.nixosModules.tailscale

      ({ pkgs, ... }: {
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        networking.hostName = "beelink";
        networking.networkmanager.enable = true;

        time.timeZone = "America/Los_Angeles";

        users.users.smallv = {
          isNormalUser = true;
          shell = pkgs.fish;
          extraGroups = [
            "wheel"
            "networkmanager"
            "video"
            "render"
          ];

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKL382w1dTlWyWU6N23PzvZ07ZPhBdfif0S57gLKFCUN ropeadope2021@gmail.com"
          ];
        };

        programs.fish.enable = true;

        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
          };
        };

        system.stateVersion = "26.05";
      })
    ];
  };
}

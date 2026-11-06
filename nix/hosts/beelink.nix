{ inputs, ... }:

{
  flake.nixosConfigurations.beelink = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    specialArgs = { inherit inputs; };

    modules = [
      inputs.self.nixosModules.diskoBeelink
      inputs.self.nixosModules.beelinkHardware
      inputs.self.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      inputs.self.nixosModules.sharedPackages
      inputs.self.nixosModules.kakouneEditor
      inputs.self.nixosModules.adguardhome
      inputs.self.nixosModules.caddy
      inputs.self.nixosModules.immich
      inputs.self.nixosModules.jellyfin
      inputs.self.nixosModules.paperless
      inputs.self.nixosModules.qbittorrent
      inputs.self.nixosModules.resticBackup
      inputs.self.nixosModules.tailscale
      inputs.self.nixosModules.syncthing
      inputs.self.nixosModules.homepage

      ({ config, pkgs, ... }: {
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

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };

        home-manager.users.smallv = {
          imports = [
            ../../home/common.nix
            ../../home/editors.nix
          ];
        };

        programs.fish.enable = true;

        systemd.services.syncthing = {
          requires = [ "mnt-Backup.mount" ];
          after = [ "mnt-Backup.mount" ];
        };

        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
          };
        };

        services.tailscale = {
          useRoutingFeatures = "server";
          extraSetFlags = [
            "--advertise-routes=192.168.68.0/24"
          ];
        };

        sops.age.keyFile = "/var/lib/sops-nix/key.txt";

        sops.secrets."restic-repository-password" = {
          sopsFile = ../../secrets/secrets.yaml;
          key = "restic/repository_password";
        };

        sops.secrets."paperless-db-password" = {
          sopsFile = ../../secrets/secrets.yaml;
          key = "paperless/db_password";
        };

        sops.templates."paperless-environment".content = ''
          PAPERLESS_DBPASS=${config.sops.placeholder."paperless-db-password"}
        '';

        system.stateVersion = "26.05";
      })
    ];
  };
}

{ inputs, ... }:

{
  flake.nixosConfigurations.lenovo = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.self.nixosModules.diskoLenovo
      inputs.self.nixosModules.broadcomWifi
      inputs.self.nixosModules.lenovoHardware
      inputs.self.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      inputs.self.nixosModules.sharedPackages
      inputs.self.nixosModules.podman
      inputs.self.nixosModules.kakouneEditor
      inputs.self.nixosModules.desktopPackages
      inputs.self.nixosModules.cosmicDesktop
      inputs.self.nixosModules.niriDesktop
      inputs.self.nixosModules.fcitx5
      inputs.self.nixosModules.syncthing
      inputs.self.nixosModules.tailscale

      ({ pkgs, ... }: {
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        nixpkgs.config.allowUnfree = true;

        networking.hostName = "lenovo";
        networking.networkmanager.enable = true;

        time.timeZone = "America/Los_Angeles";

        boot.loader.systemd-boot.configurationLimit = 3;

        systemd.tmpfiles.rules = [
          "d /var/lib/cosmic-greeter/.config 0755 cosmic-greeter cosmic-greeter -"
          "d /var/lib/cosmic-greeter/.config/cosmic 0755 cosmic-greeter cosmic-greeter -"
          "d /var/lib/cosmic-greeter/.config/cosmic/com.system76.CosmicComp 0755 cosmic-greeter cosmic-greeter -"
          "d /var/lib/cosmic-greeter/.config/cosmic/com.system76.CosmicComp/v1 0755 cosmic-greeter cosmic-greeter -"
          "L+ /var/lib/cosmic-greeter/.config/cosmic/com.system76.CosmicComp/v1/keyboard_config - - - - /etc/cosmic-greeter-keyboard_config"
        ];

        environment.etc."cosmic-greeter-keyboard_config".text = ''
          (
            numlock_state: BootOn,
          )
        '';

        users.users.smallv = {
          isNormalUser = true;
          shell = pkgs.fish;
          extraGroups = [
            "wheel"
            "networkmanager"
          ];

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKL382w1dTlWyWU6N23PzvZ07ZPhBdfif0S57gLKFCUN ropeadope2021@gmail.com"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjjHxpBIjgKh13gY3DQoq/wvN0hLWoseqjJ91sdwdnp ropeadope2021@gmail.com"
          ];
        };

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };

        home-manager.users.smallv = {
          imports = [
            ../../home/common.nix
            ../../home/cosmic.nix
            ../../home/desktop.nix
            ../../home/development.nix
            ../../home/editors.nix
            ../../home/tuios.nix
          ];
        };

        programs.fish.enable = true;

        services.pipewire = {
          enable = true;
          pulse.enable = true;
        };

        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
          };
        };

        i18n.defaultLocale = "en_US.UTF-8";
        console.keyMap = "us";

        # Set this to the release used for the initial Lenovo installation.
        sops.age.keyFile = "/var/lib/sops-nix/key.txt";
        system.stateVersion = "26.05";
      })
    ];
  };
}

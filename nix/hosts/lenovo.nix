{ inputs, ... }:

{
  flake.nixosConfigurations.lenovo = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.self.nixosModules.broadcomWifi
      inputs.self.nixosModules.lenovoHardware
      inputs.home-manager.nixosModules.home-manager
      inputs.self.nixosModules.sharedPackages
      inputs.self.nixosModules.podman
      inputs.self.nixosModules.kakouneEditor
      inputs.self.nixosModules.desktopPackages
      inputs.self.nixosModules.cosmicDesktop
      inputs.self.nixosModules.niriDesktop
      inputs.self.nixosModules.fcitx5

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
        };

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };

        home-manager.users.smallv = {
          imports = [
            ../../home/common.nix
            ../../home/desktop.nix
            ../../home/cosmic.nix
            ../../home/development.nix
          ];
        };

        programs.fish.enable = true;

        services.pipewire = {
          enable = true;
          pulse.enable = true;
        };

        i18n.defaultLocale = "en_US.UTF-8";
        console.keyMap = "us";

        # Set this to the release used for the initial Lenovo installation.
        system.stateVersion = "26.05";
      })
    ];
  };
}

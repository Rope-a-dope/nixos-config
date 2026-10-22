{ inputs, ... }:

{
  flake.nixosConfigurations.acer =
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        inputs.self.nixosModules.acerHardware
        inputs.home-manager.nixosModules.home-manager
	inputs.self.nixosModules.sharedPackages
	inputs.self.nixosModules.cosmicDesktop

        ({ pkgs, ... }: {
          # Nix
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];

          # Host and network
          networking.hostName = "acer";
          networking.networkmanager.enable = true;

          time.timeZone = "America/Los_Angeles";

	  boot.loader.systemd-boot.configurationLimit = 3;

          # User account
          users.users.smallv = {
            isNormalUser = true;
	    shell = pkgs.fish;
            extraGroups = [
              "wheel"
              "networkmanager"
            ];
          };

          # Home Manager
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

	  home-manager.users.smallv = import ../../home/common.nix;

	  programs.fish.enable = true;

          # Audio
          services.pipewire = {
            enable = true;
            pulse.enable = true;
          };

          # Locale
          i18n.defaultLocale = "en_US.UTF-8";
          console.keyMap = "us";

          # Preserve existing installation state
          system.stateVersion = "26.05";
        })
      ];
    };
}

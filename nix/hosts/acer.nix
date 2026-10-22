{ inputs, ... }:

{
  flake.nixosConfigurations.acer =
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        inputs.self.nixosModules.acerHardware

        ({ pkgs, ... }: {
          networking.hostName = "acer";
          networking.networkmanager.enable = true;

          time.timeZone = "America/Los_Angeles";

          users.users.smallv = {
            isNormalUser = true;
            extraGroups = [
              "wheel"
              "networkmanager"
            ];
          };

          # COSMIC desktop
          services.displayManager.cosmic-greeter.enable = true;
          services.desktopManager.cosmic.enable = true;

          # Audio
          services.pipewire = {
            enable = true;
            pulse.enable = true;
          };

          # Applications
          environment.systemPackages = with pkgs; [
            brave
            git
            neovim
            tree
          ];

          i18n.defaultLocale = "en_US.UTF-8";
          console.keyMap = "us";

          system.stateVersion = "26.05";
        })
      ];
    };
}

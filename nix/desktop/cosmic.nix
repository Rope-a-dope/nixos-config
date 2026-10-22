{ ... }:

{
  flake.nixosModules.cosmicDesktop = { pkgs, ... }: {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;

    environment.cosmic.excludePackages = with pkgs; [
      cosmic-player
      cosmic-term
    ];
  };
}

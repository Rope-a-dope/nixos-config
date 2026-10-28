{ ... }:
{
  flake.nixosModules.desktopPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      brave
      mpv
      qimgv
      gthumb
    ];
  };
}

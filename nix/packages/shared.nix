{ inputs, ... }:
{
  flake.nixosModules.sharedPackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        brave
        git
        neovim
        tree
        fastfetch
        podman

        # Terminal editors
        helix
        kakoune

        # Media player
        mpv

        # Image viewers
        qimgv
        gthumb
      ];
    };
}

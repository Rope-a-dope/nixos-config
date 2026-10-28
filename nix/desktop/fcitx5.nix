{ ... }:

{
  flake.nixosModules.fcitx5 = { pkgs, ... }: {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        waylandFrontend = true;

        addons = with pkgs; [
          fcitx5-rime
          fcitx5-gtk
        ];
      };
    };
  };
}

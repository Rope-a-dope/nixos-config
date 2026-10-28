{ ... }:
{
  flake.nixosModules.kakouneEditor = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      kakoune
      kak-tree-sitter
    ];
  };
}

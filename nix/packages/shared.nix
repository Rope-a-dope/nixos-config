{ inputs, ... }:

{
  flake.nixosModules.sharedPackages = { pkgs, ... }: {
    programs.fish = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      gcc
      git
      fastfetch
      flirt
      moreutils
      inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.neovim
      nixfmt
      inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.tailwindcss_4
      tree
      tree-sitter
    ];
  };
}

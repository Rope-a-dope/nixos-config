{
  description = "NixOS configurations for Acer, Lenovo, and Beelink";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:denful/import-tree";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Noctalia desktop shell (Acer and Lenovo)
    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    # Herdr terminal workspace manager (Acer and Lenovo)
    herdr-nix.url = "github:herdrdev/herdr-nix";
    herdr-nix.inputs.nixpkgs.follows = "nixpkgs";

    tuios.url = "github:Gaurav-Gosain/tuios/v0.10.1";
    tuios.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      (inputs.import-tree ./nix);
}

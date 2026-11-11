{
  config,
  pkgs,
  inputs,
  ...
}:

let
  # Kakoune Lua support
  luar = pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
    pname = "luar";
    version = "2024-10-29";
    src = pkgs.fetchFromGitHub {
      owner = "gustavo-hms";
      repo = "luar";
      rev = "2f430316f8fc4d35db6c93165e2e77dc9f3d0450";
      hash = "sha256-vHn/V3sfzaxaxF8OpA5jPEuPstOVwOiQrogdSGtT6X4=";
    };
  };

  # Kakoune fuzzy finder
  peneira = pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
    pname = "peneira";
    version = "2024-10-29";
    src = pkgs.fetchFromGitHub {
      owner = "gustavo-hms";
      repo = "peneira";
      rev = "cd47a790f3cfce9e9dfeb7a1c4ed85433c906158";
      hash = "sha256-sEyxtNu1VEsU7Txi02ZVJirwYL7GKBh2VI7SbyVht6c=";
    };
  };

  # Kakeidoscope executable
  kakouneKakeidoscope =
    let
      source = pkgs.fetchzip {
        url = "https://git.sr.ht/~orchid/kakeidoscope/archive/8b41d66fb705fd8ad6896b84bf2d9b51b595e72c.tar.gz";
        hash = "sha256:0ch7dlmrp3z2n81syp717x62c8a2jp1ir48ma44i8rvmyhsnx565";
      };
    in
    pkgs.rustPlatform.buildRustPackage {
      pname = "kakeidoscope";
      version = "1.0.0";

      src = source;

      cargoLock.lockFile = "${source}/Cargo.lock";
    };
in
{
  # Neovim configuration
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/nvim";

  # Kakoune configuration
  xdg.configFile."kak".source = pkgs.runCommand "kak-config" { } ''
    cp -r ${./kak}/. $out
    chmod -R u+w $out

    # Standard Kakoune runtime
    ln -s ${pkgs.kakoune}/share/kak/autoload/rc $out/autoload/rc

    # Luar and Peneira
    ln -s ${luar}/share/kak/autoload/plugins/luar $out/autoload/luar
    ln -s ${peneira}/share/kak/autoload/plugins/peneira $out/autoload/peneira

    # Resolve hop-kak executable
    substituteInPlace $out/autoload/user/hop.kak \
      --replace-fail '@hop-kak@' '${pkgs.kakounePlugins.hop-kak}/share/kak/bin/hop-kak'
  '';

  xdg.configFile."kak-tree-sitter/config.toml".source =
    ./kak-tree-sitter/config.toml;

  home.packages = [
    pkgs.python3
    pkgs.luajit
    kakouneKakeidoscope

    inputs.popup-kak.packages.${pkgs.stdenv.hostPlatform.system}.default

    (pkgs.kakoune-lsp.overrideAttrs (_: rec {
      version = "22.0.0";

      src = pkgs.fetchFromGitHub {
        owner = "kakoune-lsp";
        repo = "kakoune-lsp";
        tag = "v${version}";
        hash = "sha256-G4L9FOS097U7pLpYTnsUF0FK7UjQ9oQRTtH0ifsL5Ks=";
      };

      cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-QL2uE0hZtrZFJm3KpnTDXACjPY4gNefP76QjD0ZOLMo=";
      };
    }))
  ];
}

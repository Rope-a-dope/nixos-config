{
  pkgs,
  inputs,
  ...
}:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  inherit (unstable) yazi yaziPlugins;
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    package = yazi;

    plugins = {
      inherit (yaziPlugins)
        bookmarks
        bypass
        ouch
        rich-preview
        smart-filter
        sshfs
        ;

      git = {
        package = yaziPlugins.git;
        setup = true;
      };

      githead = {
        package = yaziPlugins.githead;
        setup = true;
      };
    };

    settings = {
      mgr = {
        show_hidden = true;
        show_symlink = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_sensitive = false;
        linemode = "size";
        scrolloff = 5;
      };

      preview = {
        wrap = "yes";
        tab_size = 2;
      };

      plugin = {
        prepend_fetchers = [
          {
            group = "git";
            url = "*";
            run = "git";
          }
          {
            group = "git";
            url = "*/";
            run = "git";
          }
        ];

        prepend_previewers = [
          {
            url = "*.md";
            run = "rich-preview";
          }
          {
            url = "*.rst";
            run = "rich-preview";
          }
          {
            url = "*.csv";
            run = "rich-preview";
          }
          {
            url = "*.json";
            run = "rich-preview";
          }
          {
            url = "*.ipynb";
            run = "rich-preview";
          }
          {
            mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
            run = "ouch";
          }
        ];
      };

      opener = {
        zathura = [
          {
            run = "zathura %s";
            orphan = true;
            desc = "Zathura";
            for = "unix";
          }
        ];
      };

      open.prepend_rules = [
        {
          mime = "application/pdf";
          use = "zathura";
        }
      ];
    };

    extraPackages = with pkgs; [
      ouch
      rich-cli
      ffmpeg
      jq
      poppler
      fd
      ripgrep
    ];
  };
}

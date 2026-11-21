{ pkgs, pkgs-unstable, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs-unstable.yazi;

    plugins = {
      inherit (pkgs-unstable.yaziPlugins)
        bookmarks
        bypass
        ouch
        rich-preview
        smart-filter
        sshfs
        ;

      git = {
        package = pkgs-unstable.yaziPlugins.git;
        setup = true;
      };

      githead = {
        package = pkgs-unstable.yaziPlugins.githead;
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

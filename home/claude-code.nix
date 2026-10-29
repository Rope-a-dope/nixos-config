{ inputs, pkgs, ... }:

{
  programs.claude-code = {
    enable = true;
    package = pkgs.claude-code;

    plugins = [
      "${inputs.claude-plugins-official}/external_plugins/context7"
      "${inputs.claude-plugins-official}/plugins/code-review"
      "${inputs.claude-plugins-official}/plugins/frontend-design"
      "${inputs.claude-elixir-phoenix}/plugins/elixir-phoenix"
      "${inputs.claude-elixir-phoenix}/plugins/ecto"
      "${inputs.claude-elixir-phoenix}/plugins/lv"
      "${inputs.claude-marketplace-elixir}/plugins/ash"
    ];
  };
}

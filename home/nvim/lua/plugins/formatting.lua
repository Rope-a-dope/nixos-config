return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}

      -- Use the Nix-managed StyLua instead of Mason's binary.
      opts.formatters.stylua = {
        command = "/etc/profiles/per-user/smallv/bin/stylua",
      }

      -- Use the project's own formatter configuration.
      opts.formatters_by_ft.elixir = { "mix" }
      opts.formatters_by_ft.heex = { "mix" }

      return opts
    end,
  },
}

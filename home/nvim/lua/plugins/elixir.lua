return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {
          -- Use the Nix-managed ElixirLS, not Mason's binary.
          mason = false,
          cmd = { "elixir-ls" },
        },
      },
    },
  },
}

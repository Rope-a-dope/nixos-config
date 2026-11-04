return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- Use the Nix-managed executable, not Mason.
          mason = false,

          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "svelte",
            "vue",
            "heex",
            "elixir",
          },
        },
      },
    },
  },
}

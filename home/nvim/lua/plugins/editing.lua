return {
  {
    "nvim-mini/mini.surround",
    event = { "BufReadPost", "BufNewFile" },
    keys = function()
      return {
        { "gza", desc = "Add Surrounding", mode = { "n", "x" } },
        { "gzd", desc = "Delete Surrounding" },
        { "gzr", desc = "Replace Surrounding" },
        { "gzf", desc = "Find Right Surrounding" },
        { "gzF", desc = "Find Left Surrounding" },
        { "gzh", desc = "Highlight Surrounding" },
        { "gzn", desc = "Update Surrounding Search Lines" },
      }
    end,
    opts = {
      mappings = {
        add = "gza",
        delete = "gzd",
        replace = "gzr",
        find = "gzf",
        find_left = "gzF",
        highlight = "gzh",
        update_n_lines = "gzn",
      },
    },
  },
  {
    "gbprod/substitute.nvim",
    opts = {},
    keys = {
      {
        "gss",
        function()
          require("substitute").operator()
        end,
        desc = "Substitute with motion",
      },
      {
        "gsl",
        function()
          require("substitute").line()
        end,
        desc = "Substitute line",
      },
      {
        "gS",
        function()
          require("substitute").visual()
        end,
        mode = "x",
        desc = "Substitute selection",
      },
    },
  },
}

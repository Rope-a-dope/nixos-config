return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            desc = desc,
            silent = true,
          })
        end

        -- Navigate between changed hunks
        map("n", "]h", function()
          gs.nav_hunk("next")
        end, "Next Git Hunk")

        map("n", "[h", function()
          gs.nav_hunk("prev")
        end, "Previous Git Hunk")

        -- Stage and reset hunks
        map({ "n", "x" }, "<leader>ghs", gs.stage_hunk, "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")

        -- Buffer-level actions
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghu", gs.stage_hunk, "Undo Stage Hunk")

        -- Inspect changes
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")

        -- Select a hunk as a text object
        map({ "o", "x" }, "ih", gs.select_hunk, "Inside Git Hunk")
      end,
    },
  },
}

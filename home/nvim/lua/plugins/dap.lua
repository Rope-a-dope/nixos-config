return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: Toggle UI",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Configure Elixir debugging only when ElixirLS is installed.
      local elixir_ls = vim.fn.exepath("elixir-ls")

      if elixir_ls ~= "" then
        local elixir_ls_dir =
          vim.fn.fnamemodify(vim.fn.resolve(elixir_ls), ":h:h")

        local debug_adapter =
          elixir_ls_dir .. "/scripts/debug_adapter.sh"

        if vim.fn.executable(debug_adapter) == 1 then
          dap.adapters.mix_task = {
            type = "executable",
            command = debug_adapter,
            args = {},
          }

          dap.configurations.elixir = {
            {
              type = "mix_task",
              name = "Elixir: mix test",
              request = "launch",
              task = "test",
              taskArgs = { "--trace" },
              startApps = true,
              projectDir = "${workspaceFolder}",
              requireFiles = {
                "test/**/test_helper.exs",
                "test/**/*_test.exs",
              },
            },
            {
              type = "mix_task",
              name = "Phoenix: phx.server",
              request = "launch",
              task = "phx.server",
              projectDir = "${workspaceFolder}",
            },
          }
        end
      end

      dapui.setup()
      require("nvim-dap-virtual-text").setup({})

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}

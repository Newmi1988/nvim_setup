return {
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim",
      }
    },
    config = function()
      -- mason plugin to install tools
      require("mason-nvim-dap").setup({
          ensure_installed = {
            "codelldb",
            "debugpy",
            "go-debug-adapter",
          }
      })

      -- dap configureation
      local dap = require('dap')

      vim.keymap.set("n", "<leader>dc", function()
        dap.continue()
      end, {
        desc = "Dap: Start debugger",
      })
      vim.keymap.set("n", "<leader>djs", function()
        require('dap.ext.vscode').load_launchjs()
      end, {
        desc = "Dap: Start debugger from json config",
      })
      vim.keymap.set("n", "<leader>bp", function()
        dap.toggle_breakpoint()
      end, {
        desc = "Dap: Set breakpoint",
      })
      vim.keymap.set("n", "<leader>dsi", function()
        dap.step_into()
      end, {
        desc = "Dap: Step into",
      })
      vim.keymap.set("n", "<leader>dso", function()
        dap.step_over()
      end, {
        desc = "Dap: Step over",
      })
      vim.keymap.set("n", "<leader>dro", function()
        dap.repl.open()
      end, {
        desc = "Dap: Open Repl",
      })

      -- overwrite symbols
      vim.fn.sign_define('DapBreakpoint', {
        text = '🛑',
        texthl = '',
        linehl = '',
        numhl = '',
      })

      -- Rust setup
      dap.adapters.lldb = {
        type = 'executable',
        command = os.getenv('LLDB_VSCODE'), -- adjust as needed, must be absolute path
        name = 'lldb'
      }

      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},

          -- 💀
          -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
          --
          --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
          --
          -- Otherwise you might get the following error:
          --
          --    Error on launch: Failed to attach to the target process
          --
          -- But you should be aware of the implications:
          -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
          -- runInTerminal = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp

      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          initCommands = function()
            -- Find out where to look for the pretty printer Python module
            local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

            local commands = {}
            local file = io.open(commands_file, 'r')
            if file then
              for line in file:lines() do
                table.insert(commands, line)
              end
              file:close()
            end
            table.insert(commands, 1, script_import)

            return commands
          end,
        }
      }
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

      vim.keymap.set("n", "<leader>dm", function()
        dap.test_method()
      end, {
        desc = "dap-python: Test method",
      })
      vim.keymap.set("n", "<leader>dc", function()
        dap.test_class()
      end, {
        desc = "dap-python: Test class",
      })
      vim.keymap.set("v", "<leader>ds <ESC>", function()
        dap.debug_selection()
      end, {
        desc = "dap-python: Debug selection",
      })
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
      }
    },
    config = function()
      require("dapui").setup()
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
}
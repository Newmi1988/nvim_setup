return {
  ------ Cargo
  {
    'saecki/crates.nvim',
    event = "BufEnter Cargo.toml",
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      local crates = require('crates')
      crates.setup()
      local opts = { noremap = true, silent = true }

      function add_description(table_to_update, description)
        table_to_update["desc"] = description
        return table_to_update
      end

      vim.keymap.set('n', '<leader>ct', crates.toggle,
        add_description(opts, "Crates: Toggle Plugin")
      )
      vim.keymap.set('n', '<leader>cr', crates.reload,
        add_description(opts, "Crates: Relead")
      )

      vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, 
       add_description(opts,"Crates: Show version popup")
      )
      vim.keymap.set('n', '<leader>cf', crates.show_features_popup, 
        add_description(opts,"Crates: Show feature popup")
      )
      vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, 
        add_description(opts,"Crates: Show dependencies popup")
      )
      -- Updates
      vim.keymap.set('n', '<leader>cu', crates.update_crate, 
        add_description(opts,"Crates: Update crate")
      )
      vim.keymap.set('v', '<leader>cu', crates.update_crates,
        add_description(opts,"Crates: Update selected crates")
      )
      vim.keymap.set('n', '<leader>ca', crates.update_all_crates,
        add_description(opts,"Crates: Update all crates")
      )
      vim.keymap.set('n', '<leader>cU', crates.upgrade_crate,
        add_description(opts,"Crates: Upgrade crate")
      )
      vim.keymap.set('v', '<leader>cU', crates.upgrade_crates,
        add_description(opts,"Crates: Upgrade selected crates")
      )
      vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates,
        add_description(opts,"Crates: Upgrade all crates")
      )
      vim.keymap.set('n', '<leader>cH', crates.open_homepage,
        add_description(opts,"Crates: Open homepage")
      )
      vim.keymap.set('n', '<leader>cR', crates.open_repository,
        add_description(opts,"Crates: Open repository")
      )
      vim.keymap.set('n', '<leader>cD', crates.open_documentation,
        add_description(opts,"Crates: Open documentation")
      )
      vim.keymap.set('n', '<leader>cC', crates.open_crates_io,
        add_description(opts,"Crates: Open crates.io")
      )
    end,
  },
  ------- Rust-Tools
  {
    'simrat39/rust-tools.nvim',
    config = function ()
      local rt = require("rust-tools")
      local opts = { buffer = bufnr, remap = false }

      function add_description(table_to_update,description)
        table_to_update["desc"] = description
        return table_to_update
      end

      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<leader>vca", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>vag", rt.code_action_group.code_action_group, { buffer = bufnr })
            -- defaults
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
              add_description(opts, "RustTools: Description")
            )
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
              add_description(opts, "RustTools: Query workplace Symbols")
            )
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
              add_description(opts, "RustTools: View diagnostic")
            )
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end,
              add_description(opts, "RustTools: Go to nex diagnostic")
            )
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end,
              add_description(opts, "RustTools: Go to previous diagnostic")
            )
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
              add_description(opts, "RustTools: Lsp buffer reference")
            )
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
              add_description(opts, "RustTools: Lsp buffer rename")
            )
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
              add_description(opts, "RustTools: Lsp buffer signature help")
            )
          end,
          settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
              -- enable clippy on save
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
        tools = {
                  -- rust-tools options

          -- how to execute terminal commands
          -- options right now: termopen / quickfix
          executor = require("rust-tools.executors").termopen,
          -- callback to execute once rust-analyzer is done initializing the workspace
          -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
          on_initialized = nil,
          -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
          reload_workspace_from_cargo_toml = true,
          -- These apply to the default RustSetInlayHints command
          inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            auto = true,
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- whether to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,
            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
          },
          -- options same as lsp hover / vim.lsp.util.open_floating_preview()
          hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            -- Maximal width of the hover window. Nil means no max.
            max_width = nil,
            -- Maximal height of the hover window. Nil means no max.
            max_height = nil,
            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = true,
          },
        }
      })
    end
  },
}
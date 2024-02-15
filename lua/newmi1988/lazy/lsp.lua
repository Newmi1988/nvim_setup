return {
  -- Lsp
  ---- general tokenizer and language parser (api for treesitter)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
      -- Treesitter Config
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "c",
          "lua",
          "rust",
          "python",
          "javascript",
          "go",
          "regex",
          "bash",
          "markdown",
          "markdown_inline",
        }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = {}, -- List of parsers to ignore installing
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = {}, -- list of language that will be disabled
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
  'nvim-treesitter/nvim-treesitter-context',
  ---- LSP Support
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  ----------Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
    }
  },
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
  ----------  Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  {
    'VonHeikemen/lsp-zero.nvim',
    config = function ()
      local lsp = require("lsp-zero")

      lsp.preset("recommended")

      lsp.ensure_installed({
        'tsserver',
        'lua_ls',
        'pyright',
        'rust_analyzer',
        'eslint',
        'gopls',
        'ruff_lsp',
        'yamlls',
      })

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      })
      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })


      lsp.setup_nvim_cmp({
        mapping = cmp_mappings
      })

      lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
          error = 'E',
          warn = 'W',
          hint = 'H',
          info = 'I'
        }
      })

      vim.diagnostic.config({
        virtual_text = true,
      })

      function add_description(table_to_update, description)
        table_to_update["desc"] = description
        return table_to_update
      end

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover()
        end, add_description(opts,"Lsp: Hover description")
        )
        vim.keymap.set("n", "<leader>vws", function()
          vim.lsp.buf.workspace_symbol()
        end, add_description(opts,"Lsp: Query workspace symbol")
        )
        vim.keymap.set("n", "<leader>vd", function()
          vim.diagnostic.open_float()
        end, add_description(opts,"Lsp: View diagnostics")
        )
        vim.keymap.set("n", "[d", function()
          vim.diagnostic.goto_next()
        end, add_description(opts,"Lsp: Go next")
        )
        vim.keymap.set("n", "]d", function()
          vim.diagnostic.goto_prev()
        end, add_description(opts,"Lsp: Go prev")
        )
        vim.keymap.set("n", "<leader>vca", function()
          vim.lsp.buf.code_action()
        end, add_description(opts,"Lsp: View code actions")
        )
        vim.keymap.set("n", "<leader>vrr", function()
          vim.lsp.buf.references()
        end, add_description(opts,"Lsp: References")
        )
        vim.keymap.set("n", "<leader>vrn", function()
          vim.lsp.buf.rename()
        end, add_description(opts,"Lsp: Rename")
        )
        vim.keymap.set("i", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, add_description(opts,"Lsp: Signature help")
        )
      end)


      lsp.setup()
      -- enable border on command auto completion
      -- cmp.setup({
      --   window = {
      --     completion = cmp.config.window.bordered(),
      --     documentation = cmp.config.window.bordered(),
      --   }
      -- })

      require('lspconfig.ui.windows').default_options.border = 'single'

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      require('lspconfig').jsonls.setup {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }

      require('lspconfig').yamlls.setup {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      }
    end
  },
  ---- diagnostics collector
  {
    'folke/trouble.nvim',
    config = function ()
      require("trouble").setup({})

      -- Lua
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true, desc = "toggle trouble" }
      )
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true, desc = "Touble: workspace diagnostics" }
      )
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true, desc = "Trouble: document diagnostics" }
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
        { silent = true, noremap = true, desc = "Trouble: Location list" }
      )
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true, desc = "Trouble: Toggle quickfix list" }
      )
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
        { silent = true, noremap = true, desc = "Trouble: LSP References" }
      )
    end
  },
  -- linter plugin
  {
    'mfussenegger/nvim-lint',
    config = function ()
      require('lint').linters_by_ft = {
        dockerfile = { 'hadolint', },
        python = { 'ruff', },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
}
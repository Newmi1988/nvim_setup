return {
  -- Lsp
  ---- general tokenizer and language parser (api for treesitter)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
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
          "vimdoc"
        },                   -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = {}, -- List of parsers to ignore installing
        highlight = {
          enable = true,     -- false will disable the whole extension
          disable = {},      -- list of language that will be disabled
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
    branch = 'v3.x',
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.preset("recommended")

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'pyright',
          'rust_analyzer',
          'eslint',
          'gopls',
          'yamlls',
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          -- this is the "custom handler" for `lua_ls`
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })

      local cmp = require('cmp')
      local cmp_format = lsp_zero.cmp_format()

      require('luasnip.loaders.from_vscode').lazy_load()


      cmp.setup({
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = 'menu,menuone,preview',
        },
        formatting = cmp_format,
        sources = {
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          -- scroll up and down the documentation window
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item({ behavior = 'insert' })
            else
              cmp.complete()
            end
          end),
          ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = 'insert' })
            else
              cmp.complete()
            end
          end),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
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


      lsp_zero.set_preferences({
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

      lsp_zero.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover()
        end, add_description(opts, "Lsp: Hover description")
        )
        vim.keymap.set("n", "<leader>vws", function()
          vim.lsp.buf.workspace_symbol()
        end, add_description(opts, "Lsp: Query workspace symbol")
        )
        vim.keymap.set("n", "<leader>vd", function()
          vim.diagnostic.open_float()
        end, add_description(opts, "Lsp: View diagnostics")
        )
        vim.keymap.set("n", "[d", function()
          vim.diagnostic.goto_next()
        end, add_description(opts, "Lsp: Go next")
        )
        vim.keymap.set("n", "]d", function()
          vim.diagnostic.goto_prev()
        end, add_description(opts, "Lsp: Go prev")
        )
        vim.keymap.set("n", "<leader>vca", function()
          vim.lsp.buf.code_action()
        end, add_description(opts, "Lsp: View code actions")
        )
        vim.keymap.set("n", "<leader>vrr", function()
          vim.lsp.buf.references()
        end, add_description(opts, "Lsp: References")
        )
        vim.keymap.set("n", "<leader>vrn", function()
          vim.lsp.buf.rename()
        end, add_description(opts, "Lsp: Rename")
        )
        vim.keymap.set("i", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, add_description(opts, "Lsp: Signature help")
        )
      end)


      lsp_zero.setup()

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
    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    }
  },
  -- linter plugin
  {
    'mfussenegger/nvim-lint',
    config = function()
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
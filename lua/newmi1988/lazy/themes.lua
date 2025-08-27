return {
  ---- tokio night
  'folke/tokyonight.nvim',
  -- A dark and light Neovim theme written in fennel
  'nyoom-engineering/oxocarbon.nvim',
  {
    ---- catppuccin theme
    'catppuccin/nvim',
    config = function()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      local catppuccin = require("catppuccin")
      catppuccin.setup({
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        transparent_background = false,
        term_colors = false,
        compile = {
          enabled = false,
          path = vim.fn.stdpath "cache" .. "/catppuccin",
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { 'italic' },
          functions = { 'bold' },
          keywords = { 'italic' },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { "italic" },
          operators = {},
        },
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          coc_nvim = false,
          lsp_trouble = false,
          cmp = true,
          lsp_saga = false,
          gitgutter = false,
          gitsigns = true,
          leap = true,
          telescope = true,
          nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = true,
          },
          neotree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
          },
          dap = {
            enabled = false,
            enable_ui = false,
          },
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          dashboard = true,
          neogit = false,
          vim_sneak = false,
          fern = false,
          barbar = false,
          bufferline = true,
          markdown = true,
          lightspeed = false,
          ts_rainbow = false,
          hop = false,
          notify = true,
          telekasten = true,
          symbols_outline = true,
          mini = false,
          aerial = true,
          vimwiki = true,
          beacon = true,
        },
        color_overrides = {},
        highlight_overrides = {},
      })

      -- vim.cmd [[colorscheme catppuccin]]
    end
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      -- Default options:
      require('kanagawa').setup({
        compile = false,             -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = { bold = true, italic = true},
        keywordStyle = { bold = true},
        statementStyle = { bold = true },
        typeStyle = { italic = true},
        transparent = false,         -- do not set background color
        dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        colors = {                   -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave",              -- Load "wave" theme
        background = {               -- map the value of 'background' option to a theme
          dark = "wave",           -- try "dragon" !
          light = "lotus"
        }
      })
      -- setup must be called before loading
      require("kanagawa").load("wave")
    end,
  },
}
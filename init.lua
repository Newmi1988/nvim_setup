require('newmi1988')

local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
  ---- utils (dependencies for many plugins)
  'nvim-lua/plenary.nvim',
  -- themes and ui
  ---- catppuccin theme
  'catppuccin/nvim',
  ---- tokio night
  'folke/tokyonight.nvim',
  ---- colorscheme inspired by kanagawa
  "rebelot/kanagawa.nvim",
  -- A dark and light Neovim theme written in fennel
  'nyoom-engineering/oxocarbon.nvim',
  ---- Colored brackets
  'p00f/nvim-ts-rainbow',
  ---- Highlight hover word
  'RRethy/vim-illuminate',
  ---- git signs next to lines
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },
  ---- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
  ---- Startup dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
  },
  ---- Zen mode
  "folke/zen-mode.nvim",
  ---- Statusbar
  'nvim-lualine/lualine.nvim',
  ---- Icons
  {
    'https://github.com/nvim-tree/nvim-web-devicons.git',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  -- File Manager
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    version = 'nightly'
  },
  'xiyaowong/transparent.nvim',
  -- Cmd Line and notifiycations
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  {
    "folke/noice.nvim",
    -- config = function()
    --   require("noice").setup({
    --     -- add any options here
    --   })
    -- end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  -- Fuzzy finder
  ---- fzf integration
  'junegunn/fzf.vim',
  {
    'junegunn/fzf',
  },
  ---- Telescope - Search everything
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  -- Editor tools
  ---- Toogle comments on lines
  'tpope/vim-commentary',
  ---- Show indentation line
  'lukas-reineke/indent-blankline.nvim',
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = { 'help', 'nvimtree', 'dashboard', },
        buftypes = {
          'terminal',
          'nofile',
          'quickfix',
          'prompt',
        }
      },
    },
  },
  ---- visualize undos
  'mbbill/undotree',
  ---- Multiline edit
  {
    'mg979/vim-visual-multi',
    branch = 'master'
  },
  ---- mark and jump to file
  'ThePrimeagen/harpoon',
  -- move with search label, treesitter
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function()
        require("flash").jump()
      end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function()
        require("flash").treesitter()
      end, desc = "Flash Treesitter" },
      { "r", mode = "o", function()
        require("flash").remote()
      end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function()
        require("flash").treesitter_search()
      end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function()
        require("flash").toggle()
      end, desc = "Toggle Flash Search" },
    },
  },
  -- tmux integration
  'christoomey/vim-tmux-navigator',
  --  generate docstring
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
  ---- split or join blocks
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = true,
        -- Node with syntax error will not be formatted
        check_syntax_error = true,
        -- If line after join will be longer than max value,
        -- node will not be formatted
        max_join_length = 120,
        -- hold|start|end:
        -- hold - cursor follows the node/place on which it was called
        -- start - cursor jumps to the first symbol of the node being formatted
        -- end - cursor jumps to the last symbol of the node being formatted
        cursor_behavior = 'hold',
        -- Notify about possible problems or not
        notify = true,
        -- langs = langs,
        -- Use `dot` for repeat action
        dot_repeat = true,
      })
    end,
  },
  -- Search and replace
  'nvim-pack/nvim-spectre',
  -- Circle yanked lines after input
  "gbprod/yanky.nvim",
  -- Git Plugins
  ---- nvim git integration
  'tpope/vim-fugitive',
  ---- diffviewer
  'sindrets/diffview.nvim',
  -- Lsp
  ---- general tokenizer and language parser (api for treesitter)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  'nvim-treesitter/nvim-treesitter-context',
  ---- LSP Support
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  ----------Autocompletion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  ----------  Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  'VonHeikemen/lsp-zero.nvim',
  ---- diagnostics collector
  'folke/trouble.nvim',
  -- linter plugin
  'mfussenegger/nvim-lint',
  -- Language Specific Plugins
  ---- Rust
  ------ Cargo
  {
    'saecki/crates.nvim',
    event = "BufEnter Cargo.toml",
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('crates').setup()
    end,
  },
  ------- Rust-Tools
  'simrat39/rust-tools.nvim',
  "stevearc/dressing.nvim",
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  },
  'monaqa/dial.nvim',
  "b0o/schemastore.nvim",
  -- 'mfussenegger/nvim-dap',
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies={
      {"mfussenegger/nvim-dap"}
    }
  },
  {'rcarriga/nvim-dap-ui',
    dependencies={
      {"mfussenegger/nvim-dap"}
    },
    config = function ()
     require("dapui").setup()
    end
  },
})

-- Terminal autocommands
---- Start terminal with insert mode
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

-- Fix for floating windows
-- TODO: Check after neovim update if fixed
vim.cmd("hi! link NormalFloat Normal")
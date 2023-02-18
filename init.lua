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
  ---- Colored brackets
  'p00f/nvim-ts-rainbow',
  ---- git signs next to lines
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
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
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  -- File Manager
  {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    version = 'nightly'
  },
  -- Sessions
  ---- auto session manager
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = {
          "~/",
          "~/Projects",
          "~/Downloads",
          "/"
        },
      }
    end
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
    version = '0.1.1',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  },
  -- Editor tools
  ---- Editorconfig plugin
  'editorconfig/editorconfig-vim',
  ---- Toogle comments on lines
  'tpope/vim-commentary',
  ---- Show indentation line
  'lukas-reineke/indent-blankline.nvim',
  ---- visualize undos
  'mbbill/undotree',
  ---- Multiline edit
  {
    'mg979/vim-visual-multi',
    branch = 'master'
  },
  ---- mark and jump to file
  'ThePrimeagen/harpoon',
  -- docstring generator
  {
    'kkoomen/vim-doge',
    build = 'npm i --no-save && npm run build:binary:unix'
  },
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
  ---- diagnostics renderer
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    init = function()
      vim.keymap.set("", "<leader>l", function()
        require("lsp_lines").toggle()
      end, { desc = "Toggle lsp_lines" })
    end,
    config = function()
      require("lsp_lines").setup({
        only_current_line = true,
      })
    end,
  },
  -- linter plugin
  'mfussenegger/nvim-lint',
  -- Language Specific Plugins
  ---- Rust
  ------ Cargo
  {
    'saecki/crates.nvim',
    event = "BufEnter Cargo.toml",
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('crates').setup()
    end,
  },
  ------- Rust-Tools
  'simrat39/rust-tools.nvim',
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

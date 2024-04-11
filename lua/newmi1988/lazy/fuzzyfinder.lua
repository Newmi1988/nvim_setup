return {
  -- Fuzzy finder
  ---- fzf integration
  'junegunn/fzf.vim',
  {
    'junegunn/fzf',
    config = function ()
      ---- fzf file search
      vim.api.nvim_set_keymap('n', '<C-p>', ':GFiles<CR>',
        { noremap = true, silent = true, desc = "fzf: git files" }
      )
      vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>',
        { noremap = true, silent = true, desc = "fzf: buffers" }
      )
      vim.api.nvim_set_keymap('n', '<C-g>', ':Rg<CR>',
        { noremap = true, silent = true, desc = "fzf: ripgrep" }
      )
      vim.api.nvim_set_keymap('n', '<leader>bl', ':BLines<CR>',
        { noremap = true, silent = true, desc = "fzf: ripgrep" }
      )
    end
  },
  ---- Telescope - Search everything
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function ()
      local builtin = require('telescope.builtin')
      -- Find files
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {
        desc = "Telescope: Find files",
      })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {
        desc = "Telescope: Live grep",
      })
      vim.keymap.set('n', '<leader>cb', builtin.current_buffer_fuzzy_find, {
        desc = "Telescope: Current buffer fuzzy find",
      })
      vim.keymap.set('n', '<leader>fh', builtin.oldfiles, {
        desc = "Telescope: Search file history",
      })
      -- Find buffers and search help files
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {
        desc = "Telescope: Search buffer",
      })
      vim.keymap.set('n', '<leader>cl', builtin.quickfix, {
        desc = "Telescope: Quickfix list",
      })
      vim.keymap.set('n', '<leader>ht', builtin.help_tags, {
        desc = "Telescope: Help tags",
      })
      -- lsp binds
      vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {
        desc = "Telescope: Find lsp references",
      })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {
        desc = "Telescope: Diagnostics",
      })
      vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {
        desc = "Telescope: LSP Implementation",
      })
      ---- go to lsp commands
      vim.keymap.set('n', 'go', builtin.lsp_workspace_symbols, {
        desc = "Telescope: LSP Workspace Symbols",
      })
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, {
        desc = "Telescope: LSP Document Symbols",
      })
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, {
        desc = "Telescope: LSP Definitions",
      })
      vim.keymap.set('n', 'gtd', builtin.lsp_type_definitions, {
        desc = "Telescope: Type definition",
      })
      -- git finder
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, {
        desc = "Telescope: Git commits",
      })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, {
        desc = "Telescope: Git branches",
      })
      vim.keymap.set('n', '<leader>gs', builtin.git_stash, {
        desc = "Telescope: Git stashes",
      })
      vim.keymap.set('n', '<leader>gbc', builtin.git_bcommits, {
        desc = "Telescope: Git Buffer git commits",
      })
      -- find colorschmes
      vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {
        desc = "Telescope: Colorscheme",
      })

      vim.keymap.set('n', '<leader>km', builtin.keymaps, {
        desc = "Telescope: keymaps",
      })
    end
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
}
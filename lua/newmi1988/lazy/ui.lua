return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = {
          "permissions",
          "mtime",
          "size",
          "icon",
        },
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      })
    end
  },
  ---- Colored brackets
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require 'rainbow-delimiters'

      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
  },
  ---- Highlight hover word
  'RRethy/vim-illuminate',
  ---- git signs next to lines
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs                        = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked          = true,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        yadm                         = {
          enable = false
        },
        on_attach                    = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', {
            desc = 'Gitsigns: Stage hunk',
          })
          map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', {
            desc = 'Gitsigns: Reset hunk',
          })
          map('n', '<leader>hS', gs.stage_buffer, {
            desc = 'Gitsigns: Stage buffer',
          })
          map('n', '<leader>hu', gs.undo_stage_hunk, {
            desc = 'Gitsigns: Undo stage hunk',
          })
          map('n', '<leader>hR', gs.reset_buffer, {
            desc = 'Gitsigns: Reset Buffer',
          })
          map('n', '<leader>hp', gs.preview_hunk, {
            desc = 'Gitsigns: preview_hunk',
          })
          map('n', '<leader>hb', function() gs.blame_line { full = true } end, {
            desc = 'Gitsigns: Blame line',
          })
          map('n', '<leader>tb', gs.toggle_current_line_blame, {
            desc = 'Gitsigns: Toggle current line blame',
          })
          map('n', '<leader>hd', gs.diffthis, {
            desc = 'Gitsigns: Diff this',
          })
          map('n', '<leader>hD', function() gs.diffthis('~') end, {
            desc = 'Gitsigns: Diff this ~',
          })
          map('n', '<leader>td', gs.toggle_deleted, {
            desc = 'Gitsigns: Toggle delete',
          })
          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {
            desc = 'Gitsigns: Select hunk',
          })
        end
      }
    end,
  },
  ---- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        signs = true,      -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "💤", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "ℹ︎", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
          fg = "NONE",         -- The gui style to use for the fg highlight group.
          bg = "BOLD",         -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          multiline = true,                -- enable multine todo comments
          multiline_pattern = "^.",        -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
          before = "",                     -- "fg" or "bg" or empty
          keyword = "wide",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = "fg",                    -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
          comments_only = true,            -- uses treesitter to match keywords in comments only
          max_line_len = 400,              -- ignore lines longer than this
          exclude = {},                    -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" }
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      })

      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo comment" })

      vim.keymap.set("n", "<leader>tq", ":TodoQuickFix<CR>", {
        desc = "Todo: QuickFix List",
      })
      vim.keymap.set("n", "<leader>xt", ":TodoTrouble<CR>", {
        desc = "Todo: Trouble",
      })
      vim.keymap.set("n", "<leader>tt", ":TodoTelescope<CR>", {
        desc = "Todo: Telescope",
      })
    end
  },
  ---- Startup dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require("dashboard").setup({
        theme = 'hyper',
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            {
              desc = '⇪ Update',
              group = '@property',
              action = 'Lazy update',
              key = 'u'
            },
            {
              desc = '  Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Branches',
              group = 'DiagnosticHint',
              action = 'Telescope git_branches',
              key = 'b',
            },
            {
              desc = '󱝪 Grep',
              group = 'Number',
              action = 'Telescope live_grep',
              key = 'g',
            },
            {
              desc = 'Mason',
              group = 'Number',
              action = 'Mason',
              key = 'm',
            },
          },
        },
      })
    end
  },
  ---- Zen mode
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 120, -- width of the Zen window
          height = 1,  -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false,   -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          -- twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          -- gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false }, -- disables the tmux statusline
          -- this will change the font size on alacritty when in zen mode
          -- requires  Alacritty Version 0.10.0 or higher
          -- uses `alacritty msg` subcommand to change font size
          alacritty = {
            enabled = false,
            font = "14", -- font size
          },
        },
      })
    end
  },
  ---- Statusbar
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end
  },
  ---- Icons
  {
    'https://github.com/nvim-tree/nvim-web-devicons.git',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  ---- Show indentation line
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
  -- toggle transparency
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require("transparent").setup({
        groups = { -- table: default groups
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLineNr', 'EndOfBuffer',
        },
        extra_groups = {},   -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
      })

      vim.keymap.set("n", "<leader>trt", ":TransparentToggle<CR>",
        {
          silent = true,
          noremap = true,
          desc = "Transparent: Toggle Transparents",
        }
      )
    end
  },
  {
    'stevearc/aerial.nvim',
    config = function()
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      vim.keymap.set("n", "<leader>so", "<cmd>AerialToggle!<CR>")
    end
  },
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
}
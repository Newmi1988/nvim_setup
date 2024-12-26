return {
  -- Editor tools
  ---- Toogle comments on lines
  'tpope/vim-commentary',
  ---- Surround word with parenteses
  'tpope/vim-surround',
  ---- visualize undos
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })
    end
  },
  ---- Multiline edit
  {
    'mg979/vim-visual-multi',
    branch = 'master'
  },
  ---- mark and jump to file
  {
    'ThePrimeagen/harpoon',
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file, {
        desc = "Harpoon: Add file",
      })
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, {
        desc = "Harpoon: Harpoon: Quick Menu",
      })

      vim.keymap.set("n", "<C-d>", function()
        ui.nav_file(1)
      end, {
        desc = "Harpoon: Go to 1",
      })
      vim.keymap.set("n", "<C-f>", function()
        ui.nav_file(2)
      end, {
        desc = "Harpoon: Go to 2",
      })
      vim.keymap.set("n", "<C-j>", function()
        ui.nav_file(3)
      end, {
        desc = "Harpoon: Go to 3",
      })
      vim.keymap.set("n", "<C-k>", function()
        ui.nav_file(4)
      end, {
        desc = "Harpoon: Go to 4",
      })
    end
  },
  -- move with search label, treesitter
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash"
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash"
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search"
      },
    },
  },
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
  {
    'nvim-pack/nvim-spectre',
    config = function()
      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>', {
        desc = "Spectre: Open Spectre"
      })
      vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = "Spectre: Search current word"
      })
      vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = "Spectre: Search current word"
      })
      vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
        desc = "Spectre: Search on current file"
      })
    end
  },
  -- Circle yanked lines after input
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        picker = {
          select = {
            action = nil, -- nil to use default put action
          },
          telescope = {
            mappings = nil, -- nil to use default mappings
          },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 500,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      })

      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
    end
  },
  {
    'monaqa/dial.nvim',
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.date.alias["%d.%m.%Y"], -- date (01.01.2023, etc.)
          augend.semver.alias.semver,    -- semver version (1.0.0)
          augend.integer.alias.binary,   -- binary natural number 	(0b0101, 0b11001111)
          augend.integer.alias.octal,    -- octal natural number (0o00, 0o11, 0o24)
          augend.integer.alias.hex,      -- hex natural number (0x00, 0x3f3f)
          augend.date.alias["%H:%M:%S"], -- Time in the format %H:%M:%S (14:31:06, ...)
          augend.date.alias["%H:%M"],    -- Time in the format %H:%M  (15:09, ...)
        },
      }

      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end, {
        desc = "Increment normal mode",
      })
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end, {
        desc = "Decrement normal mode",
      })
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end, {
        desc = "Increment global normal mode",
      })
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end, {
        desc = "Decrement global normal mode",
      })
      vim.keymap.set("v", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end, {
        desc = "Increment visual mode",
      })
      vim.keymap.set("v", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end, {
        desc = "Decrement normal mode",
      })
      vim.keymap.set("v", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gvisual")
      end, {
        desc = "Increment global visual mode",
      })
      vim.keymap.set("v", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gvisual")
      end, {
        desc = "Decrement global visual mode",
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
}
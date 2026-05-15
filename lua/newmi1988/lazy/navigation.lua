return {
  { "chrisgrieser/nvim-spider", lazy = true },
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
}
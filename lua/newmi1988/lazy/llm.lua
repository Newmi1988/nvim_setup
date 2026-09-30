return {
  {
    "nickjvandyke/opencode.nvim",
    -- Defaults to "main", supporting OpenCode v2.
    -- Uncomment to pull the latest stable release, supporting OpenCode v1.
    -- version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = {
          input = {
            enabled = true,
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true   -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<leader>oca", function() require("opencode").ask("@this: ") end,
        { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<leader>oce", function() require("opencode").select() end,
        { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<leader>oct", function()
        require("snacks.terminal").toggle("opencode")
      end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this") end,
        { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this") .. "_" end,
        { desc = "Add line to opencode", expr = true })

    end,
  }
}

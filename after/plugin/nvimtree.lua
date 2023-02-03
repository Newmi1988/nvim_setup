-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  view = {
    width = 30,
    mappings = {
      list = {
        { key = "v", action = "vsplit" },
        { key = "s", action = "split" },
      },
    },
  },
})


vim.api.nvim_set_keymap('n','<C-B>',':NvimTreeToggle<CR>', { noremap = true, silent = true})

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
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

vim.keymap.set("n", "<leader>dm", function()
  dap.test_method()
end, {
  desc = "dap-python: Test method",
})
vim.keymap.set("n", "<leader>dc", function()
  dap.test_class()
end, {
  desc = "dap-python: Test class",
})
vim.keymap.set("v", "<leader>ds <ESC>", function()
  dap.debug_selection()
end, {
  desc = "dap-python: Debug selection",
})
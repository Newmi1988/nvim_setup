local dap = require('dap')

vim.keymap.set("n", "<leader>dc", function()
  dap.continue()
end, {
  desc = "Dap: Start debugger",
})
vim.keymap.set("n", "<leader>djs", function()
  require('dap.ext.vscode').load_launchjs()
end, {
  desc = "Dap: Start debugger from json config",
})
vim.keymap.set("n", "<leader>bp", function()
  dap.toggle_breakpoint()
end, {
  desc = "Dap: Set breakpoint",
})
vim.keymap.set("n", "<leader>dsi", function()
  dap.step_into()
end, {
  desc = "Dap: Step into",
})
vim.keymap.set("n", "<leader>dso", function()
  dap.step_over()
end, {
  desc = "Dap: Step over",
})
vim.keymap.set("n", "<leader>dro", function()
  dap.repl.open()
end, {
  desc = "Dap: Open Repl",
})

-- overwrite symbols
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
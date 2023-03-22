local dapui = require("dapui")
dapui.setup()

vim.keymap.set('n', '<leader>do', function()
  require('dapui').toggle()
end, {
  desc = 'Dapui: toggle ui',
})

vim.keymap.set('v', '<leader>dv', function()
  require('dapui').eval()
end, {
  desc = 'Dapui: toggle ui',
})

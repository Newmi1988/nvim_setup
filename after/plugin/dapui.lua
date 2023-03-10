local dapui = require("dapui")

-- vim.keymap.set('n', '<leader>do', dapui.toggle(), {
--   desc = 'Dapui: toggle ui',
-- })

-- vim.keymap.set('v', '<leader>dv', dapui.eval(), {
--   desc = 'Dapui: toggle ui',
-- })


--- dap options
local dap = require("dap")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- local dapui = require("dapui")
-- dapui.setup()

-- vim.keymap.set('n', '<leader>do', function() dapui.toggle() end, {
--   desc = 'Dapui: toggle ui',
-- })

-- vim.keymap.set('v', '<leader>dv', function() dapui.eval() end, {
--   desc = 'Dapui: toggle ui',
-- })


-- --- dap options
-- local dap = require("dap")
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- --- python config
-- local dap = require('dap')
-- dap.adapters.python = {
--   type = 'executable',
--   command = os.getenv('VIRTUAL_ENV') .. '/.venv/bin/python',
--   args = { '-m', 'debugpy.adapter' },
-- }


-- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
-- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
-- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
-- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<Leader>tbp', function()
--   require(
--     'dap'
--   ).toggle_breakpoint()
-- end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
-- vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
--   require('dap.ui.widgets').hover()
-- end)
-- vim.keymap.set({ 'n', 'v' }, '<Leader>dpv', function()
--   require('dap.ui.widgets').preview()
-- end)
-- vim.keymap.set('n', '<Leader>df', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set('n', '<Leader>ds', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.scopes)
-- end)

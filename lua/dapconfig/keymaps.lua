local M = {}

function M.setup()
  vim.keymap.set('n', '<F5>', function() require('dap').continue() end, {
    desc = 'DAP: Continue',
  })
  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, {
    desc = 'DAP: Step over',
  })
  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, {
    desc = 'DAP: Step into',
  })
  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, {
    desc = 'DAP: Step out',
  })
  vim.keymap.set('n', '<Leader>tbp', function()
    require('dap').toggle_breakpoint()
  end)
  vim.keymap.set('n', '<Leader>dr', function()
    require('dap').repl.open()
  end, {
    desc = 'DAP: State REPL',
  })

  vim.keymap.set('n', '<Leader>dl', function()
    require('dap').run_last()
  end, {
    desc = 'DAP: Run last',
  })

  vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = 'DAP: UI Widget Hover' })

  vim.keymap.set({ 'n', 'v' }, '<Leader>dpv', function()
    require('dap.ui.widgets').preview()
  end, {
    desc = 'DAP: UI Widget Preview',
  })

  vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end, {
    desc = 'DAP: UI Widget Frames',
  })

  vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, {
    desc = 'DAP: Widget Scopes',
  })

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
end

return M

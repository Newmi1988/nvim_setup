local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'lua_ls',
  'pyright',
  'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})


lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

vim.diagnostic.config({
  virtual_text = true,
})

function add_description(table_to_update, description)
  table_to_update["desc"] = description
  return table_to_update
end

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, add_description(opts,"Lsp: Hover description")
  )
  vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
  end, add_description(opts,"Lsp: Query workspace symbol")
  )
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, add_description(opts,"Lsp: View diagnostics")
  )
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
  end, add_description(opts,"Lsp: Go next")
  )
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
  end, add_description(opts,"Lsp: Go prev")
  )
  vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
  end, add_description(opts,"Lsp: View code actions")
  )
  vim.keymap.set("n", "<leader>vrr", function()
    vim.lsp.buf.references()
  end, add_description(opts,"Lsp: References")
  )
  vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
  end, add_description(opts,"Lsp: Rename")
  )
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, add_description(opts,"Lsp: Signature help")
  )
end)


lsp.setup()

local cmp = require('cmp')

-- enable border on command auto completion
-- cmp.setup({
--   window = {
--     completion = cmp.config.window.bordered(),
--     documentation = cmp.config.window.bordered(),
--   }
-- })

require('lspconfig.ui.windows').default_options.border = 'single'
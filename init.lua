require('newmi1988')
-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup("newmi1988/lazy")

-- configure lsp
local language_servers = {
  'eslint',
  'gopls',
  'hls',
  'lua_ls',
  'ocamllsp',
  'pyright',
  'rust_analyzer',
  'ts_ls',
  'yamlls',
}

require("mason-lspconfig").setup {
  ensure_installed = language_servers,
}

vim.lsp.enable(language_servers)

-- Terminal autocommands
---- Start terminal with insert mode
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

-- fix for telescope transparency
-- TODO: Check if needed in the future
local cmd = vim.cmd
cmd 'highlight TelescopeBorder guibg=none'
cmd 'highlight TelescopeTitle guibg=none'
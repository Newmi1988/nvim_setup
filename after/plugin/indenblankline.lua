vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup({
  buftype_exclude = { "terminal" },
  space_char_blankline = " ",
  filetype_exclude = { 'help', 'nvimtree', 'dashboard' },
})

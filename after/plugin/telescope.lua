local builtin = require('telescope.builtin')
-- Find files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>cb', builtin.current_buffer_fuzzy_find, {})

-- Find buffers and search help files
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- lsp binds
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})

---- go to lsp commands
vim.keymap.set('n', 'go', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', 'gtd', builtin.lsp_type_definitions, {})

-- git finder
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gs', builtin.git_stash, {})

-- find colorschmes
vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {})

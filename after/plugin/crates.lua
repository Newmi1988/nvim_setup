local crates = require('crates')
local opts = { noremap = true, silent = true }

function add_description(table_to_update, description)
  table_to_update["desc"] = description
  return table_to_update
end

vim.keymap.set('n', '<leader>ct', crates.toggle,
  add_description(opts, "Crates: Toggle Plugin")
)
vim.keymap.set('n', '<leader>cr', crates.reload,
  add_description(opts, "Crates: Relead")
)

vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, 
 add_description(opts,"Crates: Show version popup")
)
vim.keymap.set('n', '<leader>cf', crates.show_features_popup, 
  add_description(opts,"Crates: Show feature popup")
)
vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, 
  add_description(opts,"Crates: Show dependencies popup")
)

-- Updates
vim.keymap.set('n', '<leader>cu', crates.update_crate, 
  add_description(opts,"Crates: Update crate")
)
vim.keymap.set('v', '<leader>cu', crates.update_crates,
  add_description(opts,"Crates: Update selected crates")
)
vim.keymap.set('n', '<leader>ca', crates.update_all_crates,
  add_description(opts,"Crates: Update all crates")
)
vim.keymap.set('n', '<leader>cU', crates.upgrade_crate,
  add_description(opts,"Crates: Upgrade crate")
)
vim.keymap.set('v', '<leader>cU', crates.upgrade_crates,
  add_description(opts,"Crates: Upgrade selected crates")
)
vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates,
  add_description(opts,"Crates: Upgrade all crates")
)

vim.keymap.set('n', '<leader>cH', crates.open_homepage,
  add_description(opts,"Crates: Open homepage")
)
vim.keymap.set('n', '<leader>cR', crates.open_repository,
  add_description(opts,"Crates: Open repository")
)
vim.keymap.set('n', '<leader>cD', crates.open_documentation,
  add_description(opts,"Crates: Open documentation")
)
vim.keymap.set('n', '<leader>cC', crates.open_crates_io,
  add_description(opts,"Crates: Open crates.io")
)
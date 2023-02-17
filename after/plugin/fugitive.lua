local fugitive_custom_group = vim.api.nvim_create_augroup("fugitive_custom_group", {})
local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_set_keymap('n', '<leader>gst', ':Git<CR>',
  { noremap = true, silent = true }
)

autocmd("BufWinEnter", {
  group = fugitive_custom_group,
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>p", function()
      vim.cmd [[ Git push ]]
    end, opts)

    -- rebase always
    vim.keymap.set("n", "<leader>P", function()
      vim.cmd [[ Git pull --rebase ]]
    end, opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
  end,
})

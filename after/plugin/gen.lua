require('gen').model = 'mistral:instruct' -- default 'mistral:instruct'

vim.keymap.set('v', '<leader>l', ':Gen<CR>')
vim.keymap.set('n', '<leader>l', ':Gen<CR>')

require('gen').prompts['Fix_Code'] = {
  prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  replace = true,
  extract = "```$filetype\n(.-)```"
}
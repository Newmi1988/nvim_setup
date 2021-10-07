local cmd = vim.cmd
local fn = vim.fn 
local g = vim.g
local opt = vim.opt

local Plug = vim.fn['plug#']

-- load plugins
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf.vim'
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = fn[':TSUpdate']})  -- We recommend updating the parsers on update
Plug 'editorconfig/editorconfig-vim'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'nvim-lua/completion-nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = fn[':TSUpdate']})  -- We recommend updating the parsers on update
vim.call('plug#end')

-- global options
cmd 'colorscheme onedark' -- set color theme
cmd 'syntax on'
cmd 'set number'

-- autocomplete options
-- " Set completeopt to have a better completion experience
cmd 'set completeopt=menuone,noinsert,noselect'
-- " Avoid showing message extra message when using completion
cmd 'set shortmess+=c'

g.rainbow_active = 1
g.onedark_termcolors = 256
g.rainbow_conf = {
    guifgs = {'#F8FF00','#FF64EC','#84FE77','#77FEF7'},
    ctermfgs = {'lightyellow','lightblue','lightcyan','lightmagenta'}
}

-- Key mappings
---- Helper funcs
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end

function _G.smart_tab_inv()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end


---- coursor movement
vim.api.nvim_set_keymap('n','<C-J>','<C-W><C-J>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<C-K>','<C-W><C-K>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<C-L>','<C-W><C-L>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<C-H>','<C-W><C-H>', { noremap = true, silent = true })

---- fzf file search
vim.api.nvim_set_keymap('n','<C-p>',':GFiles<CR>', { noremap = true, silent = true})

---- escape the terminal
vim.api.nvim_set_keymap('t','<Esc>','<C-\\><C-n>', {noremap = true, silent = true})

---- autocomplete
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.smart_tab_inv()', {expr = true, noremap = true})

-- LSP Config
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Autocomplete
require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

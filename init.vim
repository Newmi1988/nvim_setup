" Display settings
set number

" --- Mappings ---
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>


" Easier tab switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" --- Plugins ---
call plug#begin()

Plug 'sonph/onehalf', {'rtp': 'vim/'} 

Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'editorconfig/editorconfig-vim'
call plug#end()

colorscheme onehalfdark

" --- Settings ---


# nvim_setup
My nvim config

## Plug Install
Use the default install for plug like 

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Install the plugins with
1. Start vim

```
nvim 
```

2. Use Vim-Plug
```
:PlugInstall
```

3. Linter/LSP
Install the npm package from this [list](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)


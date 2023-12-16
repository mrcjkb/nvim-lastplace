## nvim-lastplace

A Neovim plugin that intelligently reopens files at your last edit position
(a Lua rewrite of [`vim-lastplace`](https://github.com/farmergreg/vim-lastplace)).

> [!IMPORTANT]
>
> This is a modified fork of `nvim-lastplace`, which is no longer maintained.
> The purpose of this fork is to have a package on luarocks.org.

## Prerequisites

- Neovim >= 0.9

## Installation

Install using your favourite plugin manager.

#### [rocks.nvim](https://github.com/nvim-neorocks/rocks.nvim)

```vim
:Rocks install nvim-lastplace
```

#### [Lazy](https://github.com/folke/lazy.nvim)

```lua
{
  "mrcjkb/nvim-lastplace",
  init = function()
    -- optional configuration
  end,
}
```

> [!NOTE]
>
> This fork [doesn't have a `setup` function](https://mrcjkb.dev/posts/2023-08-22-setup.html).
> It just works!

## Default config

Lua:

```lua
vim.g.nvim_lastplace = {
    ignore_buftype = { 'quickfix', 'nofile', 'help' },
    ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
    open_folds = true,
}
```

Vimscript:

```vim
let g:lastplace = {
    \ 'ignore_buftype': [ 
        \ 'quickfix',
        \ 'nofile',
        \ 'help',
        \ ],
    \ 'ignore_filetype': [
        \ 'gitcommit',
        \ 'gitrebase',
        \ 'svn',
        \ 'hgcommit',
        \ ],
    \ 'open_folds': 1,
\ }
```

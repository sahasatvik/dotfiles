vim-base16-lightline
====================

This is a theme for [vim-lightline](https://github.com/itchyny/lightline.vim),
a minimal and highly configurable statusline plugin for vim.

Despite having themes to match many popular colour schemes, I couldn't find
a theme for lightline for the excellent
[base16](https://github.com/chriskempson/base16) colour scheme.

If used in command-line vim, this theme will use the colours set by the
[base16-shell](https://github.com/chriskempson/base16-shell) scripts - meaning
that it is compatible with all of the variations of the base16 theme.

## Installation

As with any other theme, this can be installed with any of the popular plugin
managers:

 - [vim-plug](https://github.com/junegunn/vim-plug)
     - `Plug 'daviesjamie/vim-base16-lightline'`
 - [Vundle](https://github.com/VundleVim/Vundle.vim)
     - `Bundle 'daviesjamie/vim-base16-lightline'`
 - [Pathogen](https://github.com/tpope/vim-pathogen)
     - `git clone https://github.com/daviesjamie/vim-base16-lightline ~/.vim/bundle/vim-base16-lightline`

You can also install the plugin manually, by copying the files into your
`~/.vim` directory.

After it is install, you need to tell lightline to use the theme:

```VimL
let g:lightline = {
\   'colorscheme': 'base16'
\ }
```

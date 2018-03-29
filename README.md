This fork has the following (backwards compatible) fixes/improvements:

- Indent snippets when inserted
- Allow special characters as snippet names
- Autoload the plugin
- Installation instructions in README
- Avoid multiple loads of the plugin

It does not break compatibility with the [original vim-minisnip](https://github.com/KeyboardFire/vim-minisnip], only improves it.
               
               _       _           _
     _ __ ___ (_)_ __ (_)___ _ __ (_)_ __
    | '_ ` _ \| | '_ \| / __| '_ \| | '_ \
    | | | | | | | | | | \__ \ | | | | |_) |
    |_| |_| |_|_|_| |_|_|___/_| |_|_| .__/
                                    |_|

Minisnip allows you to quickly insert "templates" into
files. Among all the other snippet plugins out there, the primary goal of
minisnip is to be as minimal and lightweight as possible.

There is a deoplete source available [here](https://github.com/joereynolds/deoplete-minisnip)

## Installation

Use your favourite plugin manager to install minisnip:

#### [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'joereynolds/vim-minisnip'
```

#### [Pathogen](https://github.com/tpope/vim-pathogen):

```bash
cd ~/.vim/bundle
git clone git://github.com/joereynolds/vim-minisnip.git
```

#### [NeoBundle](https://github.com/Shougo/neobundle.vim)

```vim
NeoBundle 'joereynolds/vim-minisnip'
```

## Usage

To get started with minisnip, create a directory called `~/.vim/minisnip`.
Then placing a file called `foo` inside of it will create the `foo` snippet,
which you can access by typing `foo<Tab>` in insert mode.

Filetype-aware snippets are also available. For example, a file called
`_java_main` will create a `main` snippet only when `filetype=java`, allowing
you to add ex. a `_c_main` snippet and so on.

Here is a demo of the basic features of minisnip:

![demo GIF 1](https://raw.githubusercontent.com/KeyboardFire/keyboardfire.github.io/master/s/vim-minisnip/demo1-s.gif)

Here is another example that shows how arbitrary code can be executed from
within a snippet, allowing dynamic snippets based on the file name or other
conditions:

![demo GIF 2](https://raw.githubusercontent.com/KeyboardFire/keyboardfire.github.io/master/s/vim-minisnip/demo2-s.gif)

View [the docs](doc/) to learn the snippet syntax and options.

View [the examples](examples/) to see syntax examples.

Minisnip is licensed under MIT.

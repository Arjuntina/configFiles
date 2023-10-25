require("arjuntina")
require("arjuntina.lazy")

-- not really sure what all these do, but will investigate later
-- for now, just consider them to be "sensible defaults" :)

vim.cmd([[
set nocompatible            " disable compatibility to old-time vi -- Investigate!
set smartcase               " unique functionality in which upper case = case sensitive search, lower case = case insensitive search -- both overridden with /C i think (investigate)
set showmatch               " show matching brackets.
set hlsearch                " highlight search results
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line number for the current line
set relativenumber          " add relative line numbers
set wildmode=longest,list   " get bash-like tab completions
" set cc=88                   " set colour columns for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type -- I also need 'filetype plugin on' for vimwiki, i hope this accomplishes that too! 
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " convert tabs to white space
set shiftwidth=4            " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing

syntax on

set clipboard+=unnamedplus   " get vim to use system clipboard (hopefully)
]]
)


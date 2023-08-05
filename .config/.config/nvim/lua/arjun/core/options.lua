local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

--search settings
opt.ignorecase = true  -- if lowercase letters are used in search, search will be case insensitive (allows for quick searching)
opt.smartcase = true   -- if uppercase letters are used in search, search will be case sensitive

-- cursor line
-- sets a line below the cursor so you know what line you're one
-- disabled bc a bit confusing & in the way
opt.cursorline = false

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
-- makes vim use system keyboard when copying/pasting! 
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- considers dashes to be parts of a word! 
-- eg. "hi-there" is considered 1 word instead of 3
opt.iskeyword:append("-")

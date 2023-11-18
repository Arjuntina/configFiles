-- Some general settings here!
-- Transfer from the initial init.lua file
-- is there a better place to include? hmmm

vim.opt.smartcase = true 
-- sets smartcase searching to true
-- aka. lowercase = case-insensitive, uppercase = case-sensitive
-- override with /c and /C flags



require("arjuntina.remap") -- file for remapping keybinds

require("arjuntina.lazy") -- file for loading plugins!

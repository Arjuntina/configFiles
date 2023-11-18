vim.g.mapleader = " "

-- first option = mode:
--  i = insert mode
--  n = normal mode
--  v = visual mode
--  x = visual block mode
--  t = term mode
--  c = command mode

-- Window Management
-- moving focus btwn windows
-- spc-w-direction
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "Move window focus left"})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "Move window focus down"})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "Move window focus up"})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "Move window focus right"})
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
-- resizing windows
-- spc-w-Direction
vim.keymap.set("n", "<leader>wH", "<C-w><")
vim.keymap.set("n", "<leader>wL", "<C-w>>")
vim.keymap.set("n", "<leader>wK", "") -- figure out!
vim.keymap.set("n", "<leader>wJ", "") -- figure out!

-- Tabs!
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<CR>", {desc = "open new tab"})
vim.keymap.set("n", "<C-c>", "<cmd>tabclose<CR>", {desc = "close tab"})


-- Text Management
-- moving text up/down
-- in normal mode:
-- vim.keymap.set("n", "K", "ddkP")
-- vim.keymap.set("n", "J", "ddjP")
-- in visual-block mode:
vim.keymap.set("x", "L", ">+1<CR>gv-gv")
vim.keymap.set("x", "H", "<+1<CR>gv-gv")
vim.keymap.set("x", "J", "djP") -- figure out for J/K moving!

-- NVIM Tree
vim.keymap.set("n", "<leader>d", "<cmd>NvimTreeToggle<CR>") -- toggle file explorer (equivalent of Dired mode)
-- vim.keymap.set("n", "l", "") -- toggle file explorer (equivalent of Dired mode)
-- see https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt and try eventually

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find files in recent files" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy string in cwd" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Fuzzy string under cursor in cwd" })

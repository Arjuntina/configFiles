-- for configuring lazy packages!


-- grab the latest release of the lazy package manager! (copied from the Installation readme)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
},
{
    "folke/tokyonight.nvim",
    opts = { 
        style = "moon",
        on_colors = function(colors)
            colors.fg_gutter = colors.blue1
        end
    },
    init = function()
        --load the colorscheme
        vim.cmd([[colorscheme tokyonight]])
    end
},
{
    "vimwiki/vimwiki"
}
})

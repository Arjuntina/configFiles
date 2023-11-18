return {
    "folke/tokyonight.nvim",
    priority = 1000;
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
}

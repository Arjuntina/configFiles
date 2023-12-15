return {
    "lervag/vimtex",
    config = function()
        -- all lines below copied from the documentation
        -- i have no idea what I'm doing tbh
        vim.cmd([[syntax enable]])
        -- set the default pdf viewer
        vim.cmd([[let g:vimtex_view_method = 'zathura']])
        -- explicitly set the local leader (same as default key)
        vim.cmd([[let maplocalleader = "\\"]])
        -- conceal latex delimiter code unless you are editing the specific line of the text!
        -- eg. replaces $ delimiters & \in + \cap by their corresponding unicode symbols
        vim.cmd([[set conceallevel=1]])
    end,
}

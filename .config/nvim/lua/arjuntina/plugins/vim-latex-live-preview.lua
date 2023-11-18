return {
    "xuhdev/vim-latex-live-preview",
    init = function()
        -- set the default pdf viewer
        vim.cmd([[let g:livepreview_previewer = 'zathura']])
    end,
    enabled = false
}

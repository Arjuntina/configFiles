return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Notioooos",
        path = "~/Files/noteFiles/Notioooos",
      },
    },

    -- to detect the current directory as a vault and use it
    detect_cwd = true,
    
    -- Optional, completion.
    completion = {
        -- If using nvim-cmp, otherwise set to false
        nvim_cmp = true,
        -- Trigger completion at 2 chars
        min_chars = 2,
        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "current_dir",

        -- Control how wiki links are completed with these options:

        -- Whether to add the note ID during completion.
        -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
        -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
        prepend_note_id = true,

        -- Whether to add the note path during completion.
        -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
        -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
        prepend_note_path = false,

        -- Whether to only use paths during completion.
        -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
        -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
        use_path_only = false,
    },

    mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["<leader>gf"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    -- Make it so that links can be opened
    follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({"xdg-open", url})  -- linux
    end,

    -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    open_app_foreground = true,

    -- Optional, by default commands like `:ObsidianSearch` will attempt to use
    -- telescope.nvim, fzf-lua, and fzf.vim (in that order), and use the
    -- first one they find. By setting this option to your preferred
    -- finder you can attempt it first. Note that if the specified finder
    -- is not installed, or if it the command does not support it, the
    -- remaining finders will be attempted in the original order.
    finder = "telescope.nvim",

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example `:ObsidianQuickSwitch`
    -- will show the notes sorted by latest modified time
    sort_by = "modified",
    sort_reversed = true,

    -- Optional, determines whether to open notes in a horizontal split, a vertical split,
    -- or replacing the current buffer (default)
    -- Accepted values are "current", "hsplit" and "vsplit"
    open_notes_in = "vsplit",

    -- Specify how to handle attachments.
    attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "images",  -- This is the default
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
        -- The is the default implementation.
        ---@param client obsidian.Client
        ---@param path Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
            local link_path
            local vault_relative_path = client:vault_relative_path(path)
            if vault_relative_path ~= nil then
                -- Use relative path if the image is saved in the vault dir.
                link_path = vault_relative_path
            else
                -- Otherwise use the absolute path.
                link_path = tostring(path)
            end
            local display_name = vim.fs.basename(link_path)
            return string.format("![%s](%s)", display_name, link_path)
        end,
    },
  },
}

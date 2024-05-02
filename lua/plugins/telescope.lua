return {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "natecraddock/telescope-zf-native.nvim",
    },
    cmd = "Telescope",
    keys = {
        {
            "<leader>ff",
            function() require("telescope.builtin").fd() end,
            desc = "[F]ind [F]iles"
        },
        {
            "<leader>fg",
            function() require("telescope.builtin").live_grep() end,
            desc = "[F]ind by [G]rep"
        },
        {
            "<leader>fb",
            function() require("telescope.builtin").buffers() end,
            desc = "[F]ind [B]uffers"
        },
        {
            "<leader>fh",
            function() require("telescope.builtin").help_tags() end,
            desc = "[F]ind [H]elp"
        },
        {
            "<leader>fr",
            function() require("telescope.builtin").oldfiles() end,
            desc = "[F]ind [R]ecent files"
        },
    },

    config = function()
        local actions = require("telescope.actions")
        local open_with_trouble = require("trouble.sources.telescope").open

        -- Use this to add more results without clearing the trouble list
        local add_to_trouble = require("trouble.sources.telescope").add

        require("telescope").setup({
            defaults = {
                winblend = 20,
                mappings = {
                    i = { ["<C-t"] = open_with_trouble },
                    n = { ["<C-t"] = open_with_trouble }
                }
            },
        })
        require("telescope").load_extension("zf-native")
    end,
}

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
    opts = {
        defaults = {
            winblend = 20,
        }
    },

    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("zf-native")
    end,
}

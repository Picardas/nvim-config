return {
    {
        "echasnovski/mini.surround",
        version = "*",
        event = { "BufReadPost", "BufNewFile" },
        opts = {}
    },
    {
        "echasnovski/mini.clue",
        version = "*",

        config = function(_)
            require("mini.clue").setup({
                triggers = {
                    -- Leader triggers
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },
                    -- Built-in completion
                    { mode = "i", keys = "<C-x>" },
                    -- `g` key
                    { mode = "n", keys = "g" },
                    { mode = "x", keys = "g" },
                    -- Marks
                    { mode = "n", keys = "'" },
                    { mode = "n", keys = '`' },
                    { mode = "x", keys = "'" },
                    { mode = "x", keys = '`' },
                    -- Registers
                    { mode = "n", keys = '"' },
                    { mode = "x", keys = '"' },
                    { mode = "i", keys = "<C-r>" },
                    { mode = "c", keys = "<C-r>" },
                    -- Window commands
                    { mode = "n", keys = "<C-w>" },
                    -- `z` key
                    { mode = "n", keys = "z" },
                    { mode = "x", keys = "z" },
                    -- mini.surround
                    { mode = "n", keys = "s" },
                    { mode = "v", keys = "s" }
                },

                window = {
                    delay = 250,
                },
                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    require("mini.clue").gen_clues.builtin_completion(),
                    --require("mini.clue").gen_clues.g(),
                    require("mini.clue").gen_clues.marks(),
                    require("mini.clue").gen_clues.registers(),
                    require("mini.clue").gen_clues.windows(),
                    require("mini.clue").gen_clues.z(),
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile"},
        opts = {}
    },
    {
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
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
        opts = {}
    },
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        version = "*",
        cmd = {
            "ToggleTerm",
            "TermExec",
        },
        keys = {
            {
                "<leader>tt",
                function()
                    local term_size = math.floor(vim.api.nvim_win_get_height(0) * 0.3)
                    vim.cmd.ToggleTerm({ "size=" .. term_size, "direction=horizontal", "name=Terminal" })
                end,
                desc = "[T]oggle [T]erminal"
            }
        },

        config = function()
            local term_group = vim.api.nvim_create_augroup("TermGroup", { clear = true } )
            vim.api.nvim_create_autocmd("TermOpen", {
                group = term_group,
                pattern = { "*" },
                callback = function(event)
                    local buf = { buffer = event.buf }
                    -- Enter command mode with esc
                    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], buf )
                    -- Default window commands
                    vim.keymap.set("t", "<C-w>j", "<cmd>wincmd j<cr>", buf )
                    vim.keymap.set("t", "<C-w>k", "<cmd>wincmd k<cr>", buf )
                    vim.keymap.set("t", "<C-w>h", "<cmd>wincmd h<cr>", buf )
                    vim.keymap.set("t", "<C-w>l", "<cmd>wincmd l<cr>", buf )
                    -- No confirmation with bd
                    vim.keymap.set("c", "bd<cr>", "bd!<cr>", buf )

                    -- Disable colourcolum
                    vim.opt_local.colorcolumn = "0"
                    -- Always treat the terminal buffer as unmodified
                    vim.opt_local.modified = false
                    -- No scroll off
                    vim.opt_local.scrolloff = 0
                    vim.opt_local.sidescrolloff = 0
                end,
            })
            require("toggleterm").setup()
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    }
}

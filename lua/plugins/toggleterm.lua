return {
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
}

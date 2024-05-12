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
                vim.cmd("ToggleTerm size=" .. term_size .. " direction=horizontal name=Terminal")
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
                local map = function(keys, func)
                    vim.keymap.set("t", keys, func, { buffer = event.buf } )
                end

                map("<esc>", [[<C-\><C-n>]])
            end,
        })
        require("toggleterm").setup()
    end
}

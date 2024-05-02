return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            vim.o.statusline = " "
        end
    end,

    opts = {
        options = {
            section_separators = "",
            component_separators = "|",
        }
    },
    config = function(_, opts)
        require("lualine").setup(opts)
        vim.cmd([[ :set noshowmode ]])
    end
}

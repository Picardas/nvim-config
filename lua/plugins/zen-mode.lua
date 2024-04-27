return {
    "folke/zen-mode.nvim",
    keys = {
        { "<leader>tf", "<cmd>ZenMode<cr>", desc = "[T]oggle [F]ocus Mode"}
    },
    opts = {
        plugins = {
            options = {
                laststatus = 3,
            }
        }
    }
}

-- Python Specific Settings
vim.opt_local.colorcolumn = "80"
vim.opt_local.textwidth = 72

-- Use treesitter to enable textwidth for text when working on python docstrings, from nvim-cmp
local comment_tw = vim.api.nvim_create_augroup("CommentTextWidth", { clear = true })
vim.api.nvim_create_autocmd("TextChangedI", {
    group = comment_tw,
    callback = function()
        local context = require("cmp.config.context")
            if context.in_treesitter_capture("string.documentation") == true then
                vim.opt_local.formatoptions:append("t")
            else
                vim.opt_local.formatoptions:remove("t")
        end
    end
})

return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        overrides = function(colors)
            return {
                -- Block-like modern Telescope UI
                TelescopeTitle = { fg = colors.theme.ui.special, bold = true },
                TelescopePromptNormal = { bg = colors.theme.ui.bg_p1 },
                TelescopePromptBorder = { fg = colors.theme.ui.bg_p1, bg = colors.theme.ui.bg_p1 },
                TelescopeResultsNormal = { fg = colors.theme.ui.fg_dim, bg = colors.theme.ui.bg_m1 },
                TelescopeResultsBorder = { fg = colors.theme.ui.bg_m1, bg = colors.theme.ui.bg_m1 },
                TelescopePreviewNormal = { bg = colors.theme.ui.bg_dim },
                TelescopePreviewBorder = { bg = colors.theme.ui.bg_dim, fg = colors.theme.ui.bg_dim },
            }
        end,
    },

    config = function(_, opts)
        require("kanagawa").setup(opts)
        require("kanagawa").load("dragon")
    end,
}

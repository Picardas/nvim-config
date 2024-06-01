
return {
    {
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
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        init = function()
            -- Don't show statusline until lualine has loaded
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
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile"},
        main = "ibl",
        opts = {}
    },
    {
        "https://github.com/RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile"},

        config = function()
            require("illuminate").configure({
                modes_denylist = { "v", "V" }
            })

            -- change the highlight style
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

            --- auto update the highlight style on colorscheme change
            vim.api.nvim_create_autocmd({ "ColorScheme" }, {
            pattern = { "*" },
            callback = function(ev)
                vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
                vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
                vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
            end
            })

        end,
    },
    {
        "xiyaowong/virtcolumn.nvim"
    },
    {
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
}

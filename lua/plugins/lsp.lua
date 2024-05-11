return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "basedpyright",
                "lua-language-server",
                "powershell-editor-services"
            }
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                 end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {
        -- Lspconfig
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "j-hui/fidget.nvim", opts = {} }
        },

        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("Lsp-Attach", { clear = true} ),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc } )
                    end

                    -- Jump to definition of word under cursor
                    -- Use <C-t> to go back
                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    -- Find references for word under cursor
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    -- Jump to implemtation of word under cursor
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    -- Jump to type of word under cursor
                    map("gT", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
                    -- Find all symbols in document
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    -- Find all symbols in workspace
                    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                    --- Rename variable under cursor
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
                    -- Execute code action - Cursor should be on error or language server suggestion
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    -- Pop-up documentation for word under cursor
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    -- Jump to Declaration - NOT Definition
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    -- Manage workspace folders
                    map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
                    map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
                    map("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "[W]orkspace [L]ist Folders")

                end,
            })

            -- Broadcast nvim-cmp capibilities to neovim
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Configure language servers here
            local servers = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = "standard"
                    }
                },
                lua_ls = {},
                powershell_es = {}
            }

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
})

-- Clear Highlights after search
local hl_ns = vim.api.nvim_create_namespace('search')
local hlsearch_group = vim.api.nvim_create_augroup('hlsearch_group', { clear = true })

local function manage_hlsearch(char)
    local key = vim.fn.keytrans(char)
    local keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }

    if vim.fn.mode() == 'n' then
        if not vim.tbl_contains(keys, key) then
        vim.cmd([[ :set nohlsearch ]])
        elseif vim.tbl_contains(keys, key) then
        vim.cmd([[ :set hlsearch ]])
        end
    end

  vim.on_key(nil, hl_ns)
end

vim.api.nvim_create_autocmd('CursorMoved', {
    group = hlsearch_group,
    callback = function()
        vim.on_key(manage_hlsearch, hl_ns)
    end,
})

-- Remember last cursor position opening buffer
local position_group = vim.api.nvim_create_augroup("PositionCursor", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
    group = position_group
})

-- Remove trailing whitespace on save
local whitespace_group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })
-- end of line
vim.api.nvim_create_autocmd("BufWritePre", { command = [[:%s/\s\+$//e]], group = whitespace_group, })
--end of file
vim.api.nvim_create_autocmd("BufWritePre", { command = [[:%s#\($\n\s*\)\+\%$##e]], group = whitespace_group, })

-- Set formating settings
local comment_group = vim.api.nvim_create_augroup("FormatOptions", { clear = true })

vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    command = [[set formatoptions-=o]],
    group = comment_group,
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    command = [[set formatoptions-=t]],
    group = comment_group,
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    command = [[set formatoptions-=l]],
    group = comment_group,
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    command = [[set formatoptions+=n]],
    group = comment_group,
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    command = [[set formatoptions+=1]],
    group = comment_group,
})

-- Only show cursor line on active buffer
local cursor_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = cursor_group,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- close some filetypes with <q>
local close_group = vim.api.nvim_create_augroup("CloseGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = close_group,
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
  },
  callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Spell check in text filetypes
local spell_group = vim.api.nvim_create_augroup("SpellGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = spell_group,
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
local auto_mkdir_group = vim.api.nvim_create_augroup("MkdirGroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = auto_mkdir_group,
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
        return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- resize splits if window got resized
local resize_group = vim.api.nvim_create_augroup("ResizeGroup", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = resize_group,
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

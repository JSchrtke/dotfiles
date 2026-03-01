vim.o.number = true
vim.o.relativenumber = true
vim.o.grepprg = "rg --vimgrep"
vim.o.clipboard = "unnamedplus"
vim.o.listchars = "tab:-->,eol:↲,nbsp:␣,space:•,trail:•,extends:⟩,precedes:⟨"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.tabstop = 8
vim.o.shiftwidth = 8
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.colorcolumn = "80,100,120"
vim.o.signcolumn = "yes"
vim.g.mapleader = " "
vim.o.wrap = false
vim.o.foldlevelstart = 99

-- keymaps
local map = vim.api.nvim_set_keymap
-- quickfix list
map('n', '<C-n>', ':cnext<cr>', {})
map('n', '<C-p>', ':cprev<cr>', {})
-- diagnostic
map("n", "sd", ":lua vim.diagnostic.open_float()<CR>", {})
map("n", "sad", ":lua vim.diagnostic.setqflist({ title = 'Diagnostics' })<CR>", {})
map("n", "se", ":lua vim.diagnostic.setqflist({ title = 'Errors', severity = vim.diagnostic.severity.ERROR })<CR>", {})
map("n", "]e", ":lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", {})
map("n", "[e", ":lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", {})


-- lsp config
vim.lsp.config['lua'] = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        settings = {
                Lua = {
                        diagnostics = {
                                globals = { 'vim' }
                        }
                },
        },
        root_markers = {
                '.luarc.json',
                '.luarc.jsonc',
                '.luacheckrc',
                '.stylua.toml',
                'stylua.toml',
                'selene.toml',
                'selene.yml',
                '.git',
        },
}
vim.lsp.enable('lua')

vim.cmd("colorscheme melange")

vim.lsp.config['gopls'] = {
        cmd = { "gopls" },
        filetypes = { "go" },
        root_markers = {
                "go.mod",
                ".git",
        },
}
vim.lsp.enable("gopls")

vim.lsp.config['rust-analyzer'] = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = {
                "Cargo.toml",
                ".git",
        },
}
vim.lsp.enable("rust-analyzer")

vim.lsp.config['tsserver'] = {
        cmd = { "npx", "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "typescript" },
        root_markers = { "package.json", ".git" },
}
vim.lsp.enable("tsserver")

local treesitter_filetypes = {
        'bash',
        'c',
        'cpp',
        'css',
        'go',
        'html',
        'javascript',
        'lua',
        'rust',
        'scss',
        'typescript',
        'vim',
}
require('nvim-treesitter').install(treesitter_filetypes)

local start_treesitter = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end
vim.api.nvim_create_autocmd('FileType', {
        pattern = treesitter_filetypes,
        callback = start_treesitter,
})

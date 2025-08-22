-- Enable line numbers with Current line --> absolute, Others --> relative
vim.opt.number = true
vim.opt.relativenumber = true

-- Map ii for escape key, and reset time for second keypress duration.
vim.keymap.set('i', 'ii', '<Esc>')
vim.opt.timeoutlen = 50

-- Gruvbox color scheme for nevim screen (Appimage version runs in its own screen)
-- Bypass neovim colorscheme and use the terminal colors instead

vim.o.termguicolors = true
vim.cmd("colorscheme default")
vim.cmd("hi Normal guibg=None guifg=None")

-- Use Windows clipboard in WSL
vim.opt.clipboard = "unnamedplus"

-- Set custom provider (useful if "+y still not working)
vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
}

require("config.lazy")

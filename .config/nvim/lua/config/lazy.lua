-- ===============================
-- Basic bootstrap for lazy.nvim
-- ===============================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"



-- ===============================
-- Plugins
-- ===============================
require("lazy").setup({
  -- Install plugins here


  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },


  -- Mason for LSP/formatters/linters
  { "williamboman/mason.nvim" },


  -- Mason bridge to lspconfig
  { "williamboman/mason-lspconfig.nvim" },


  -- Core LSP config
  { "neovim/nvim-lspconfig" },


  -- Gruvbox theme
  {
    "luisiacc/gruvbox-baby",
    config = function()
    vim.o.background = "dark"
    vim.cmd("colorscheme gruvbox-baby")

    -- keep transparent background
    vim.cmd("hi Normal guibg=None")

    -- Make “dull white” tokens pure bold white
    vim.cmd("hi @variable guifg=#FFFFFF gui=bold")
    vim.cmd("hi @text guifg=#FFFFFF gui=bold")
    vim.cmd("hi @constant guifg=#FFFFFF gui=bold")
    end,
  },

})



-- ===============================
-- Mason setup
-- ===============================
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright" },
})


-- ===============================
-- LSP setup
-- ===============================
require("lspconfig").pyright.setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(client, bufnr)
    if client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens.on_attach(client, bufnr)
    end
  end,
})

-- ===============================
-- Treesitter runtime config
-- ===============================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "lua", "bash", "javascript", "rust", "cpp" },
  highlight = {
    enable = true,          -- enable syntax highlighting
    additional_vim_regex_highlighting = false, -- optional
  },
})

-- Modern Neovim Configuration

-- Basic Options
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.joinspaces = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }

-- Auto-detect macOS system theme
local theme = vim.fn.system('defaults read -g AppleInterfaceStyle 2>/dev/null')
vim.opt.background = theme:match('Dark') and 'dark' or 'light'

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Theme: Kanagawa with lotus (light) variant
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({})
    end,
  },

  -- Statusline with minimal configuration
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
        sections = {
          lualine_x = { "filetype" },
          lualine_y = {},
        },
      })
    end,
  },

  -- Tree-sitter for improved syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    config = function()
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end
      configs.setup({
        ensure_installed = { "lua", "python", "typescript", "javascript", "markdown", "bash" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Shows available keybindings on <leader> press
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({ delay = 400 })
    end,
  },

  -- Native LSP configuration and server installer
  -- cmp-nvim-lsp is a dep here so capabilities are ready when LSP attaches
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls" },
        automatic_installation = true,
      })

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
      end

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lsp_servers = {
        lua_ls = {
          cmd = { 'lua-language-server' },
          root_markers = { '.luarc.json', '.luacheckrc', '.stylua.toml', 'stylua.toml' },
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {
          cmd = { 'pyright-langserver', '--stdio' },
          root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt' },
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",         -- "off", "basic", or "strict"
                reportMissingImports = "none",      -- suppress unresolved import errors
                reportMissingModuleSource = "none", -- suppress "not a known import symbol"
              },
            },
          },
        },
        ts_ls = {
          cmd = { 'typescript-language-server', '--stdio' },
          root_markers = { 'package.json', 'tsconfig.json' },
        },
      }

      for server, config in pairs(lsp_servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end

      vim.lsp.enable({ 'lua_ls', 'pyright', 'ts_ls' })
    end,
  },

  -- Autocompletion engine with LSP integration
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- Fuzzy finder for files, grep, buffers, etc.
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Find text" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Find buffers" },
      { "<leader>fr", function() require("telescope.builtin").oldfiles() end,   desc = "Recent files" },
    },
  },

  -- Git change indicators in sign column
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    keys = {
      { "]c", "<cmd>Gitsigns next_hunk<CR>",    desc = "Next hunk" },
      { "[c", "<cmd>Gitsigns prev_hunk<CR>",    desc = "Previous hunk" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
    },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
      })
    end,
  },
})

vim.cmd.colorscheme("kanagawa-lotus")

-- Essential Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Visual indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- File browser
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.keymap.set("n", "-", "<cmd>Explore<CR>", { desc = "File browser" })

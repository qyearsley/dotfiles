-- Modern Neovim Configuration with Native LSP

-- ============================================================================
-- Basic Vim Options
-- ============================================================================
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.joinspaces = false
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true
-- Auto-detect macOS system theme and set background
local theme = vim.fn.system('defaults read -g AppleInterfaceStyle 2>/dev/null')
if theme:match('Dark') then
  vim.opt.background = 'dark'
else
  vim.opt.background = 'light'
end
vim.opt.listchars = "tab:▷▷⋮"

-- Additional recommended options
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.signcolumn = "yes"      -- Always show sign column
vim.opt.updatetime = 300        -- Faster completion
vim.opt.timeoutlen = 300        -- Faster key sequence completion
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Enable filetype detection
vim.cmd[[filetype plugin indent on]]
vim.cmd[[syntax on]]

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Bootstrap lazy.nvim Plugin Manager
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugin Specifications
-- ============================================================================
require("lazy").setup({
  -- ============================================================================
  -- LSP & Language Support
  -- ============================================================================

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason for LSP server management
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration for neovim
      { "folke/neodev.nvim", opts = {} },
    },
  },

  -- ============================================================================
  -- Autocompletion & Snippets
  -- ============================================================================

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Completion sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
  },

  -- ============================================================================
  -- Syntax Highlighting & Editing
  -- ============================================================================

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Only essential languages you actually use
        ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "html", "markdown", "markdown_inline", "bash" },
        auto_install = true,  -- Auto-install when opening new file types
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- Auto-pairs for brackets and quotes (automatically close brackets/quotes as you type)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      -- Integrate with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Fast and easy commenting (gcc to toggle line comment, gc in visual mode)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- ============================================================================
  -- Navigation & Fuzzy Finding
  -- ============================================================================

  -- Fuzzy finder for files, text, buffers
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
    end,
  },

  -- ============================================================================
  -- Git Integration
  -- ============================================================================

  -- Git integration - shows changes in sign column
  {
    "lewis6991/gitsigns.nvim",
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

  -- ============================================================================
  -- UI Enhancements
  -- ============================================================================

  -- Shows available keybindings in a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        preset = "modern",
      })
    end,
  },

  -- Better statusline with file info, git status, LSP info
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      -- Use solarized theme matching the background
      local lualine_theme = vim.o.background == "dark" and "solarized_dark" or "solarized_light"
      require("lualine").setup({
        options = {
          theme = lualine_theme,
          component_separators = "|",
          section_separators = "",
          icons_enabled = false,
        },
      })
    end,
  },

  -- ============================================================================
  -- AI Integration
  -- ============================================================================

  -- Claude Code integration - Terminal wrapper for Claude Code CLI
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup({
        window = {
          position = "vertical",   -- Vertical split (sidebar)
          split_ratio = 0.4,       -- 40% of screen width
        },
      })
    end,
  },
})

-- Apply colorscheme (uses your local colors/NeoSolarized.vim)
vim.cmd[[colorscheme NeoSolarized]]

-- ============================================================================
-- LSP Configuration
-- ============================================================================
-- Setup Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ts_ls" },
  automatic_installation = true,
})

-- LSP keymaps - will be set on LSP attach
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)

  -- Documentation
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

  -- Actions
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)

  -- Diagnostics
  vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

-- Configure diagnostics display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Setup LSP servers using new vim.lsp.config API (Neovim 0.11+)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Python
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile' },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- TypeScript/JavaScript
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Enable LSP servers (start them automatically when opening files)
vim.lsp.enable({ 'lua_ls', 'pyright', 'ts_ls' })

-- ============================================================================
-- Autocompletion Setup
-- ============================================================================
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})

-- ============================================================================
-- Additional Keymaps
-- ============================================================================
-- Clear search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- ============================================================================
-- Telescope Keymaps
-- ============================================================================
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Find text (grep)" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Find help" })
vim.keymap.set("n", "<leader>fr", telescope_builtin.oldfiles, { desc = "Find recent files" })

-- ============================================================================
-- Gitsigns Keymaps
-- ============================================================================
-- Navigation between git hunks
vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next git hunk" })
vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous git hunk" })
-- Actions
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })

-- ============================================================================
-- Netrw (built-in file browser) Configuration
-- ============================================================================
vim.g.netrw_banner = 0        -- Hide banner (press I to toggle)
vim.g.netrw_liststyle = 3     -- Tree view
vim.g.netrw_browse_split = 0  -- Open files in same window

-- ============================================================================
-- Netrw Keymaps
-- ============================================================================
-- Open file browser in current directory
vim.keymap.set("n", "-", "<cmd>Explore<CR>", { desc = "Open file browser" })

-- ============================================================================
-- Comment.nvim Keymaps
-- ============================================================================
-- Uses default keybindings:
-- gcc - Toggle line comment
-- gbc - Toggle block comment
-- gc - Toggle comment (in visual mode)

-- ============================================================================
-- Claude Code Keymaps
-- ============================================================================
-- Toggle Claude Code (default: <leader>ac and <C-,>)
vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })

-- Conversation management
vim.keymap.set("n", "<leader>cr", "<cmd>ClaudeCodeResume<CR>", { desc = "Claude Code: Resume conversation" })
vim.keymap.set("n", "<leader>cn", "<cmd>ClaudeCodeContinue<CR>", { desc = "Claude Code: Continue last conversation" })
vim.keymap.set("n", "<leader>cv", "<cmd>ClaudeCodeVerbose<CR>", { desc = "Claude Code: Verbose mode" })

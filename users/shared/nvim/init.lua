-- https://neovim.io/doc/user/lua-guide.html#lua-guide

-- deps
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- history
vim.opt.undofile = true

vim.opt.showmode = false
vim.opt.laststatus = 2
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.title = true

-- tabs
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- delays
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

vim.opt.shortmess = "AIT"

-- windows
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { nbsp = "¬", tab = ">•", extends = "»", precedes = "«", trail = "¶" }
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "

vim.keymap.set('n', '<esc>', ':nohlsearch<cr>')
vim.keymap.set('n', '<leader>w', ":write<cr>")
vim.keymap.set('n', ";", ":")
vim.keymap.set('n', "<leader>y", ":%y+<cr>")

vim.keymap.set('n', '<leader>t', ":NvimTreeToggle<cr>")
vim.keymap.set('n', '<leader>f', ":NvimTreeFindFile<cr>")

vim.keymap.set('n', '<leader>c', ':normal gcc<CR>', { desc = 'Toggle comment line' })
vim.keymap.set('v', '<leader>c', '<Esc>:normal gvgc<CR>', { desc = 'Toggle comment block' })

require("lazy").setup({
  "airblade/vim-rooter",
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup {}
    end,
  },
  "sirtaj/vim-openscad",
  "nvim-tree/nvim-tree.lua",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  "lukas-reineke/indent-blankline.nvim",
  "nvim-lualine/lualine.nvim",
  -- lsp
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "neovim/nvim-lspconfig",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "html",
        "markdown",
        "elixir",
        "eex",
        "heex",
        "rust",
        "javascript",
        "css",
        "dockerfile",
        "css",
        "json",
        "nix"
      },
      auto_install = true,
      highlight = {
        enable = true
      },
      indent = { enable = true }
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  -- themes
  {
    "ksevelyar/joker.vim",
    lazy = false,    -- to make sure it's loaded on startup
    priority = 1000, -- to load before other plugins
    config = function()
      vim.cmd.colorscheme("joker")
    end
  },
  {
    "rebelot/kanagawa.nvim",
  }
})

-- # LSP
local lspconfig = require('lspconfig')

-- ## CMP
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- cmp integration
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  mapping = {
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      { 'i' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      { 'i' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  }, {
    { name = 'buffer' } })
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local silent = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, silent)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, silent)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, silent)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, silent)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufsilent = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufsilent)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufsilent)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufsilent)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufsilent)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufsilent)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufsilent)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufsilent)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufsilent)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufsilent)
  vim.keymap.set('n', '<space>=', function()
    vim.lsp.buf.format { async = true }
  end, silent)

  vim.keymap.set('n', '<leader>h', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end)
end

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.elixirls.setup {
  on_attach = on_attach,
  cmd = { "elixir-ls" },
  capabilities = capabilities
}

-- npm install -g typescript typescript-language-server
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.nil_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ['nil'] = {
      formatting = {
        command = { "alejandra" }
      }
    }
  }
}

lspconfig.eslint.setup {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    client.server_capabilities.completion = false
  end
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

-- # lualine
require 'lualine'.setup {
  options = {
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    always_divide_middle = false
  },
  sections = {
    lualine_a = {
      { 'filename', symbols = { modified = ' + ', readonly = '  ', unnamed = 'No Name' } }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      { 'diagnostics', symbols = { error = '● ', warn = '● ', info = '● ', hint = '● ' } }
    },
    lualine_z = { 'branch' }
  },
  inactive_sections = {
    lualine_a = {
      { 'filename', symbols = { modified = ' + ', readonly = '  ', unnamed = 'No Name' } }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- # nvim-tree
local function on_nvim_tree_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings. Feel free to modify or remove as you wish.
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))

  -- Mappings migrated from view.mappings.list
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'g', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', '<Space>y', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require 'nvim-tree'.setup {
  on_attach = on_nvim_tree_attach,
  view = {
    side = 'left',
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },
  renderer = {
    icons = { show = { file = false, folder = true, folder_arrow = false, git = true } }
  },
  actions = {
    open_file = { quit_on_open = false, resize_window = false, window_picker = { enable = false } }
  }
}

-- # telescope
require 'telescope'.setup {
  defaults = {
    file_ignore_patterns = { "^./.git/" },
    layout_config = {
      width = 0.98,
      height = 0.98
    },
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader>r', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.git_branches, {})
vim.keymap.set('n', '<leader>m', builtin.oldfiles, {})

-- # indent_blankline
require("ibl").setup { indent = { char = "|" } }

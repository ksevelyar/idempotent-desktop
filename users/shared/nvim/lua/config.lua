-- # LSP
local lspconfig = require('lspconfig')

-- ## CMP
vim.opt.completeopt = {'menu', 'menuone', 'noselect'} -- cmp integration
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  mapping = {
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
                             {'i'}),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
                           {'i'}),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
    ['<CR>'] = cmp.mapping.confirm({select = true})
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, {name = 'vsnip'}
  }, {{name = 'buffer'}})
})
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>=', vim.lsp.buf.formatting, bufopts)
end

lspconfig.rust_analyzer.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.elixirls.setup {
  on_attach = on_attach,
  cmd = {"/home/ksevelyar/work/elixir-ls/release/language_server.sh"},
  -- cmd = {"/run/current-system/sw/bin/elixir-ls"},
  capabilities = capabilities
}

lspconfig.rnix.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

vim.api.nvim_command("au BufWritePre *.js,*.vue EslintFixAll")
lspconfig.eslint.setup {
  on_attach = function(client)
    client.resolved_capabilities.completion = false
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.range_formatting = true
  end
}

-- # lualine
require'lualine'.setup {
  options = {
    icons_enabled = true,
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    always_divide_middle = false
  },
  sections = {
    lualine_a = {
      {'filename', symbols = {modified = ' + ', readonly = '  ', unnamed = 'No Name'}}
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {'diagnostics', symbols = {error = '● ', warn = '● ', info = '● ', hint = '● '}}
    },
    lualine_z = {'branch'}
  },
  inactive_sections = {
    lualine_a = {
      {'filename', symbols = {modified = ' + ', readonly = '  ', unnamed = 'No Name'}}
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
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local list = {
  {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")}, {key = {"g"}, cb = tree_cb("cd")},
  {key = "<C-v>", cb = tree_cb("vsplit")}, {key = "<C-x>", cb = tree_cb("split")},
  {key = "<C-t>", cb = tree_cb("tabnew")}, {key = "<", cb = tree_cb("prev_sibling")},
  {key = ">", cb = tree_cb("next_sibling")}, {key = "P", cb = tree_cb("parent_node")},
  {key = "<BS>", cb = tree_cb("close_node")}, {key = "<Tab>", cb = tree_cb("preview")},
  {key = "K", cb = tree_cb("first_sibling")}, {key = "J", cb = tree_cb("last_sibling")},
  {key = "I", cb = tree_cb("toggle_ignored")}, {key = "H", cb = tree_cb("toggle_dotfiles")},
  {key = "R", cb = tree_cb("refresh")}, {key = "a", cb = tree_cb("create")},
  {key = "d", cb = tree_cb("remove")}, {key = "D", cb = tree_cb("trash")},
  {key = "r", cb = tree_cb("rename")}, {key = "<C-r>", cb = tree_cb("full_rename")},
  {key = "x", cb = tree_cb("cut")}, {key = "c", cb = tree_cb("copy")},
  {key = "p", cb = tree_cb("paste")}, {key = "y", cb = tree_cb("copy_name")},
  {key = "Y", cb = tree_cb("copy_path")}, {key = "<Space>y", cb = tree_cb("copy_absolute_path")},
  {key = "[c", cb = tree_cb("prev_git_item")}, {key = "]c", cb = tree_cb("next_git_item")},
  {key = "u", cb = tree_cb("dir_up")}, {key = "s", cb = tree_cb("system_open")},
  {key = "q", cb = tree_cb("close")}, {key = "?", cb = tree_cb("toggle_help")}
}

require'nvim-tree'.setup {
  view = {
    hide_root_folder = false,
    side = 'left',
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {custom_only = false, list = list}
  },
  renderer = {
    icons = {show = {file = false, folder = true, folder_arrow = false, git = true}}
  },
  actions = {
    open_file = {quit_on_open = false, resize_window = false, window_picker = {enable = false}}
  }
}

-- # telescope
require'telescope'.setup {
  defaults = { file_ignore_patterns= {"^./.git/"} },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

-- # indent_blankline
require("indent_blankline").setup {}

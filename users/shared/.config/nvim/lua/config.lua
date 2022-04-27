local lspconfig = require('lspconfig')
local g = vim.g

local prettier = {
  formatCommand = 'prettier --stdin-filepath ${INPUT}',
  formatStdin = true
}
local luaformatter = {
  formatCommand = 'lua-format -i --indent-width=2',
  formatStdin = true
}

require'navigator'.setup({
  treesitter_analysis = true,
  icons = {
    code_action_icon = '🔨',
    diagnostic_err = '●',
    diagnostic_warn = '●',
    diagnostic_info = [[●]],
    diagnostic_hint = [[●]],
    diagnostic_virtual_text = ''
  },
  lsp = {
    diagnostic_scrollbar_sign = false,
    disable_format_cap = {"tsserver", "sumneko_lua"},
    disable_lsp = {"flow", "vuels", "denols"},
    tsserver = {
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.range_formatting = false
      end,

      handlers = {['textDocument/publishDiagnostics'] = function(...) end}
    },
    efm = {
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
      end,
      init_options = {codeAction = true, document_formatting = true},
      root_dir = lspconfig.util.root_pattern({'.git/', 'package.json'}),

      filetypes = {"css", "html", "json", "lua", "markdown"},
      settings = {
        log_level = 1,
        log_file = '~/efm.log',
        languages = {
          css = {prettier},
          html = {prettier},
          json = {prettier},
          lua = {luaformatter},
          markdown = {prettier}
        }
      }
    }
  }
})

local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  mapping = {
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
    ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, {name = 'vsnip'} -- For vsnip users.
  }, {{name = 'buffer'}})
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
require'lspconfig'.elixirls.setup {
  cmd = {"/run/current-system/sw/bin/elixir-ls"},
  capabilities = capabilities
}

vim.api.nvim_command(
    "au BufWritePost *.ex,*.exs,*.nix lua vim.lsp.buf.formatting_sync(nil, 200)")

vim.api.nvim_command("au BufWritePre *.js,*.vue EslintFixAll")

require'lspconfig'.rnix.setup {capabilities = capabilities}

require'lspconfig'.eslint.setup {
  on_attach = function(client)
    client.resolved_capabilities.completion = false
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.range_formatting = true
  end
}

require'lualine'.setup {
  options = {
    icons_enabled = true,
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    always_divide_middle = false
  },
  sections = {
    lualine_a = {
      {
        'filename',
        symbols = {modified = ' + ', readonly = '  ', unnamed = 'No Name'}
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        'diagnostics',
        symbols = {error = '● ', warn = '● ', info = '● ', hint = '● '}
      }
    },
    lualine_z = {'branch'}
  },
  inactive_sections = {
    lualine_a = {
      {
        'filename',
        symbols = {modified = ' + ', readonly = '  ', unnamed = 'No Name'}
      }
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

g.nvim_tree_show_icons = {git = 1, folders = 1, files = 0, folder_arrows = 0}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local list = {
  {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
  {key = {"g"}, cb = tree_cb("cd")}, {key = "<C-v>", cb = tree_cb("vsplit")},
  {key = "<C-x>", cb = tree_cb("split")},
  {key = "<C-t>", cb = tree_cb("tabnew")},
  {key = "<", cb = tree_cb("prev_sibling")},
  {key = ">", cb = tree_cb("next_sibling")},
  {key = "P", cb = tree_cb("parent_node")},
  {key = "<BS>", cb = tree_cb("close_node")},
  {key = "<Tab>", cb = tree_cb("preview")},
  {key = "K", cb = tree_cb("first_sibling")},
  {key = "J", cb = tree_cb("last_sibling")},
  {key = "I", cb = tree_cb("toggle_ignored")},
  {key = "H", cb = tree_cb("toggle_dotfiles")},
  {key = "R", cb = tree_cb("refresh")}, {key = "a", cb = tree_cb("create")},
  {key = "d", cb = tree_cb("remove")}, {key = "D", cb = tree_cb("trash")},
  {key = "r", cb = tree_cb("rename")},
  {key = "<C-r>", cb = tree_cb("full_rename")},
  {key = "x", cb = tree_cb("cut")}, {key = "c", cb = tree_cb("copy")},
  {key = "p", cb = tree_cb("paste")}, {key = "y", cb = tree_cb("copy_name")},
  {key = "Y", cb = tree_cb("copy_path")},
  {key = "<Space>y", cb = tree_cb("copy_absolute_path")},
  {key = "[c", cb = tree_cb("prev_git_item")},
  {key = "]c", cb = tree_cb("next_git_item")},
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
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {enable = false}
    }
  }
}

require'telescope'.setup {pickers = {find_files = {hidden = true}}}

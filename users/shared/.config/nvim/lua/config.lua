local lspconfig = require('lspconfig')

local eslint = {
  lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c: %m'},
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin = true,
}

local prettier = {formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true}
local luaformatter = {formatCommand = 'lua-format -i', formatStdin = true}

require'navigator'.setup({
  treesitter_analysis = true,
  lsp = {
    tsserver = {
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
      end,
    },
    efm = {
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.completion = false
      end,
      init_options = {documenFormatting = true, codeAction = true, document_formatting = true},
      root_dir = lspconfig.util.root_pattern({'.git/', '.'}),

      filetypes = {
        "javascript",
        "vue",
        "scss",
        "css"
      },
      settings = {
        log_level = 1,
        log_file = '~/efm.log',
        languages = {
          less = {prettier},
          css = {prettier},
          html = {prettier},
          javascript = {eslint},
          vue = {eslint},
          json = {prettier},
          lua = {luaformatter},
          markdown = {prettier},
          scss = {prettier},
          typescript = {prettier, eslint},
          yaml = {prettier},
        }
      }
    }
  }
})

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.elixirls.setup{
  cmd = { "/run/current-system/sw/bin/elixir-ls" };
  capabilities = capabilities
}

vim.api.nvim_command("au BufWritePost *.ex,*.exs,*.nix lua vim.lsp.buf.formatting_sync(nil, 2000)")

require'lspconfig'.rnix.setup{
  capabilities = capabilities
}

require'nvim-tree'.setup()

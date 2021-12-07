require'lspconfig'.elixirls.setup{
  cmd = { "/run/current-system/sw/bin/elixir-ls" };
}

local lspconfig = require('lspconfig')

local eslint = {
  lintCommand = 'eslint -f unix --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c: %m'},
  formatCommand = 'eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin = true,
}

local prettier = {formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true}
local luaformatter = {formatCommand = 'lua-format -i', formatStdin = true}

require'navigator'.setup({
  treesitter_analysis = true,
  lsp = {
    tsserver = {
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
      end,
    },
    efm = {
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
      end,
      init_options = {documenFormatting = true, codeAction = true, document_formatting = true},
      root_dir = lspconfig.util.root_pattern({'.git/', '.'}),

      filetypes = {
        "javascript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "typescript",
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
          javascript = {prettier, eslint},
          javascriptreact = {prettier, eslint},
          vue = {prettier, eslint},
          json = {prettier},
          lua = {luaformatter},
          markdown = {prettier},
          scss = {prettier},
          typescript = {prettier, eslint},
          typescriptreact = {prettier, eslint},
          yaml = {prettier},
          ["javascript.jsx"] = {prettier, eslint},
          ["typescript.tsx"] = {prettier, eslint},
        }
      }
    }
  }
})

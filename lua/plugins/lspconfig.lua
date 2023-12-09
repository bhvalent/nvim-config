local config = function()
  local lspconfig = require('lspconfig')
  
  -- lua 
  lspconfig.lua_ls.setup({
    -- capabilities = capabilities,
    -- on_attach = on_attach,
    settings = {
      Lua = {
        -- make the language server recognize 'vim' global
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true
          }
        }
      }
    }
  })
  
  local stylua = require('efmls-configs.formatters.stylua')

  -- configure efm server
  lspconfig.efm.setup({
    filetypes = {
      'lua'
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true
    },
    settings = {
      languages = {
        lua = { stylua }
      }
    }
  })

  -- Format on Save
  local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
  vim.api.nvim_create_autocmd('BugWritePost', {
    group = lsp_fmt_group,
    callback = function()
      local efm = vim.lsp.get_active_clients({ name = 'efm' })

      if vim.tbl_isempty(efm) then
        return
      end

      vim.lsp.buf.format({ name = 'efm' })
    end
  })
end

return {
  'neovim/nvim-lspconfig',
  config = config,
  lazy = false,
  dependencies = {
    'windwp/nvim-autopairs',
    'williamboman/mason.nvim',
    'creativenull/efmls-configs-nvim'
  }
}

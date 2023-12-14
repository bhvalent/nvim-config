local config = function()
  require('lualine').setup {
    options = {
      theme = "tokyonight",
      globalstatus = true
    },
    sections = {
      lualine_a = {
        {
          'buffers'
        }
      }
    }
  }
end

return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  config = config
}

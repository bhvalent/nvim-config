return {
  'akinsho/toggleterm.nvim',
  version = "*",
  lazy = false,
  opts = {
    direction = "vertical",
    size = function()
      return vim.o.columns * 0.4
    end,
    open_mapping = [[<c-t>]],
  },
  config = true
}

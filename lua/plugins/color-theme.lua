return {
  "folke/tokyonight.nvim",
	lazy = false,
	priority = 999,
	config = function()
		require("tokyonight").setup({
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent"
      }
		})
    vim.cmd [[ colorscheme tokyonight ]]
	end
}

return {
	"cpea2506/one_monokai.nvim",
	lazy = false,
	priority = 999,
	config = function()
		require("one_monokai").setup({
			transparent = true
		})
	end
}

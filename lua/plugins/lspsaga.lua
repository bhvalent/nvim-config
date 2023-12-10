return {
	"glepnir/lspsaga.nvim",
	lazy = false,
	config = function()
		require("lspsaga").setup({
			-- keybindings for navigation in lspsaga window
			move_in_saga = { prev = "<c-k>", next = "<c-j>" },
			-- use enter to open file with finder
			finder_action_keys = {
				open = "<CR>",
			},
			-- use enter to open file with definition preview
			definition_action_keys = {
				edit = "<CR>",
			},
			code_action = {
        keys = {
          -- use escape to exit code action float window instead of q
          quit = "<Esc>",
        },
      }
		})
	end,
}


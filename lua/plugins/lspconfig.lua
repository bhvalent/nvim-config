local config = function()
	local lspconfig = require("lspconfig")
	local signs = { Error = " ", Warn = " ", Hint = "?", Info = "" }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

  -- enable keybinds only for when lsp server available
  local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- set keybindsmapkey("<leader>fd", "Lspsaga finder", "n", opts) -- go to definition
    vim.keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references 
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- go to declaration
    vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
    vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show diagnostics for line
    vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
    vim.keymap.set("n", "leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  end

	-- lua
	lspconfig.lua_ls.setup({
		-- capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				-- make the language server recognize 'vim' global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	local stylua = require("efmls-configs.formatters.stylua")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { stylua }
			},
		},
	})

	-- Format on Save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })

			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
	},
}


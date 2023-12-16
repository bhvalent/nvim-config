local on_attach = require("utils.lsp").on_attach
local signs = require("utils.icons").diagnostic_signs

local config = function()
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	local capabilities = cmp_nvim_lsp.default_capabilities()

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
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

	-- typescript
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig", ".git"),
	})

	-- Golang
	lspconfig.gopls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"go",
			"gomod",
			"gowork",
			"gotmpl",
		},
		root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
				},
			},
		},
	})

	local stylua = require("efmls-configs.formatters.stylua")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local gofumpt = require("efmls-configs.formatters.gofumpt")
	local goimports = require("efmls-configs.formatters.goimports")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"typescript",
			"go",
			"gomod",
			"gowork",
			"gotmpl",
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
				lua = { stylua },
				typescript = { eslint_d, prettierd },
				go = { gofumpt, goimports },
				gomod = { gofumpt, goimports },
				gowork = { gofumpt, goimports },
				gotmpl = { gofumpt, goimports },
			},
		},
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
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}


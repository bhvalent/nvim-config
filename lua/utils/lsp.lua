local keymap = vim.keymap
local lspUtils = {}

-- enable keybinds only for when lsp server available
lspUtils.on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybindsmapkey("<leader>fd", "Lspsaga finder", "n", opts) -- go to definition
  keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references 
  keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- go to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

  -- Example of conditional keymap by lsp
  -- if client.name == "pyright" then
  --   keymap.set(...)
  -- end

  if client.name == "gopls" then
    local dap = require("dap")
    keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts) -- toggle breakpoint
    keymap.set("n", "<F5>", dap.continue, opts) -- continue/invoke debugger
    keymap.set("n", "<F10>", dap.step_over, opts) -- step over
    keymap.set("n", "<F11>", dap.step_into, opts) -- step into
    keymap.set("n", "<F12>", dap.step_out, opts) -- step out

    local dapgo = require("dap-go")
    keymap.set("n", "<leader>dt", dapgo.debug_test, opts) -- debug test
  end
end

return lspUtils

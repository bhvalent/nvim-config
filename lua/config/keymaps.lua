local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Directory Navigation
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", opts)

-- Pane Navigation
keymap.set("n", "<c-h>", "<c-w>h", opts) -- Navigate Left
keymap.set("n", "<c-j>", "<c-w>j", opts) -- Navigate Down
keymap.set("n", "<c-k>", "<c-w>k", opts) -- Navigate Up
keymap.set("n", "<c-l>", "<c-w>l", opts) -- Navigate Right

-- Window Management
keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", opts) -- Split Vertically
keymap.set("n", "<leader>sh", "<cmd>split<CR>", opts) -- Split Horizontally
keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", opts) -- Toggle Minimize

-- Comments
vim.api.nvim_set_keymap("n", "<c-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<c-_>", "gcc", { noremap = false })

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Git
keymap.set("n", "<leader>Gc", "<cmd>DiffviewOpen<CR>", opts) -- open git changes
keymap.set("n", "<leader>Gh", "<cmd>DiffviewFileHistory<CR>", opts) -- open git history
keymap.set("n", "<leader>Gfh", "<cmd>DiffviewFileHistory %<CR>", opts) -- open git history for current file
keymap.set("n", "<leader>Gq", "<cmd>DiffviewClose<CR>", opts) -- close git

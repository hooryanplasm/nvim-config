vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights on search" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move to upper window" })

vim.keymap.set("n", "<leader>fs", "<cmd>write<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "<leader>o", "<cmd>source<CR>", { silent = true, desc = "Source current file" })
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

vim.keymap.set("n", "<leader>y", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative path" })

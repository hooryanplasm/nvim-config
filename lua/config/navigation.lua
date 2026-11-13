local fzf = require("fzf-lua")
fzf.setup({ "skim" })

local function pick_cwd()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == "" then
    vim.notify("No file in current buffer", vim.log.levels.WARN)
    return
  end

  local current_dir = vim.fn.fnamemodify(current_file, ":h")
  if current_dir == "" then
    current_dir = "."
  end

  fzf.files({ cwd = current_dir })
end

vim.keymap.set("n", "<leader>s.", "<cmd>Oil<cr>", { desc = "Open Oil" })
vim.keymap.set("n", "<leader><leader>", fzf.files, { desc = "Search files" })
vim.keymap.set("n", "<leader>.", pick_cwd, { desc = "Search files in current directory" })
vim.keymap.set("n", "<leader>s<leader>", fzf.history, { desc = "Search history" })
vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "Search buffers" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep_native, { desc = "Search with grep" })
vim.keymap.set("n", "<leader>s/", fzf.grep_curbuf, { desc = "Search current buffer" })
vim.keymap.set("n", "<leader>sc", fzf.colorschemes, { desc = "Search colorschemes" })

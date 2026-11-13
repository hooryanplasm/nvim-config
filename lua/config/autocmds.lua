vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.hl_op()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Wrap text buffers",
  pattern = { "markdown", "text", "gitcommit" },
  group = vim.api.nvim_create_augroup("wrap-text", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

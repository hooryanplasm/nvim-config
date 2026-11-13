local languages = {
  "javascript",
  "typescript",
  "tsx",
  "python",
  "sql",
  "nix",
  "dockerfile",
  "c",
  "bash",
  "html",
  "lua",
  "markdown",
  "xml",
  "go",
}

require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
  pattern = languages,
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

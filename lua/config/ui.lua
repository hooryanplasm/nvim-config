vim.opt.background = "dark"
vim.cmd.colorscheme("kanagawa-dragon")

require("neoscroll").setup({ duration = 100, easing = "sine" })
require("todo-comments").setup()
require("mini.pairs").setup()
require("nvim-web-devicons").setup()
require("which-key").setup({
  delay = 0,
  icons = { mappings = true },
  spec = {
    { "<leader>f", group = "[F]ile", mode = { "n", "v" } },
    { "<leader>fs", group = "[F]ile [S]ave", mode = { "n", "v" } },
    { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
    { "<leader>t", group = "[T]oggle" },
    { "gr", group = "LSP Actions", mode = { "n" } },
  },
})

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "diff", "diagnostics" },
    lualine_c = { "lsp_status", "filename", "searchcount" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "fzf" },
})

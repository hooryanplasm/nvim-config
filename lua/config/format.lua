local javascript_formatters = {
  { "oxfmt", "--stdin-filepath", "$FILENAME" },
  { "biome", "format", "--stdin-file-path", "$FILENAME" },
}

local external_formatters = {
  lua = {
    { "stylua", "--stdin-filepath", "$FILENAME", "-" },
  },
  python = {
    { "isort", "--stdout", "--filename", "$FILENAME", "-" },
    { "black", "--stdin-filename", "$FILENAME", "-q", "-" },
  },
  javascript = javascript_formatters,
  javascriptreact = javascript_formatters,
  typescript = javascript_formatters,
  typescriptreact = javascript_formatters,
}

local function trim_trailing_whitespace(bufnr)
  local filetype = vim.bo[bufnr].filetype
  if filetype == "markdown" or filetype == "text" then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local changed = false

  for index, line in ipairs(lines) do
    local trimmed = line:gsub("%s+$", "")
    if trimmed ~= line then
      lines[index] = trimmed
      changed = true
    end
  end

  if changed then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  end
end

local function expand_command(template, filename)
  local command = {}
  for _, argument in ipairs(template) do
    command[#command + 1] = argument:gsub("%$FILENAME", filename)
  end
  return command
end

local function format_with_external(bufnr)
  local formatters = external_formatters[vim.bo[bufnr].filetype]
  if not formatters then
    return false
  end

  local filename = vim.api.nvim_buf_get_name(bufnr)
  local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  local ran = false

  for _, template in ipairs(formatters) do
    local command = expand_command(template, filename)
    if vim.fn.executable(command[1]) == 1 then
      local result = vim.system(command, { stdin = content, text = true }):wait(1000)
      if not result or result.code ~= 0 then
        local error_message = result and result.stderr or "timed out"
        vim.notify(("Formatter %s failed:\n%s"):format(command[1], error_message), vim.log.levels.WARN)
        return true
      end

      content = result.stdout
      ran = true
    end
  end

  if not ran then
    return false
  end

  local lines = vim.split(content:gsub("\n$", ""), "\n", { plain = true })
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  return true
end

local function format_with_lsp(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/formatting" })
  if #clients == 0 then
    return false
  end

  vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 1000 })
  return true
end

local function format(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].buftype ~= "" or not vim.bo[bufnr].modifiable then
    return
  end

  if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
    return
  end

  trim_trailing_whitespace(bufnr)

  if format_with_external(bufnr) then
    return
  end

  format_with_lsp(bufnr)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("autoformat", { clear = true }),
  pattern = "*",
  callback = function(args)
    format(args.buf)
  end,
})

vim.lsp.config("tsgo", {
  cmd = function(dispatchers, config)
    local command = "tsc"
    if vim.fn.executable("tsgo") == 1 then
      command = "tsgo"
    elseif config and config.root_dir then
      local local_command = vim.fs.joinpath(config.root_dir, "node_modules/.bin/tsgo")
      if vim.fn.executable(local_command) == 1 then
        command = local_command
      end
    end

    return vim.lsp.rpc.start({ command, "--lsp", "--stdio" }, dispatchers)
  end,
})

vim.lsp.enable({
  "tsgo",
  "lua_ls",
  "gopls",
  "pyright",
  "nixd",
  "sqls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename symbol" })
    vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code action" })
    vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })

    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local methods = vim.lsp.protocol.Methods

    if client:supports_method(methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("hover-highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("hover-lsp-detach", { clear = true }),
        callback = function(detach_event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "hover-highlight", buffer = detach_event.buf })
        end,
      })
    end

    if client:supports_method(methods.textDocument_inlayHint) then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = event.buf })
      end, { buffer = event.buf, desc = "Toggle inlay hints" })
    end
  end,
})

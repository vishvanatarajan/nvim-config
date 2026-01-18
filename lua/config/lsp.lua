-- Enable the LSP servers
-- NOTE: Modify the path for each LSP in the respective scripts
-- located in the lsp folder.
vim.lsp.enable({
  'clangd',
  'gopls',
  'basedpyright', -- Requires basedpyright-langserver and Ruff installed
  'rust_analyzer',
  'tsserver',
  'html_ls',
  'css_ls',
  'json_ls',
  'java_ls' -- Requires eclipse.jdt.ls and need to set JDTLS_HOME on PATH.
})

-- Setup LspAttach autocommand to enable features based on the client
-- capabilities. A single autocommand can work for multiple LSP servers.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})

-- Setup CursorHold autocommand to open diagnostic float for displaying
-- errors and warnings from the LSP servers.
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    -- Only open the float if there are diagnostics on the current line
    local diagnostics =
      vim.diagnostic.get(0, { lnum = vim.fn.getcurpos()[2] - 1 })
    if next(diagnostics) then
      vim.diagnostic.open_float(nil, {
        scope = 'cursor',
        focusable = false,
        border = 'single',
        wrap = true,
      })
    end
  end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  underline = true,
})

-- Enable the LSP servers
vim.lsp.enable({
  'lua_ls', -- Requires [https://github.com/luals/lua-language-server] on PATH.
  'clangd', -- Relies on compile_commands.json being in the project root.
  'gopls', -- Requires gopls on PATH.
  'basedpyright', -- Requires basedpyright-langserver on PATH.
  'rust_analyzer', -- Requires rust-analyzer on PATH.
  'ts_ls', -- Requires typescript-langauge-server installed globally or locally
  'html', -- Requires vscode-html-language-server installed globally or locally
  'cssls', -- Requires vscode-css-langauge-server installed globally or locally
  'jsonls', -- Requires vscode-json-langauge-server installed globally or local
  'jdtls' -- Requires PATH variable to contain folder of jdtls binary.
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

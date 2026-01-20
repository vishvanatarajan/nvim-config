-- Enable the LSP servers
vim.lsp.enable({
  -- Requires basedpyright-langserver to be installed and located on PATH.
  'basedpyright',
  -- Requires clangd to be installed and located on PATH.
  -- Further, compile_commands.json must be present in the project root.
  'clangd',
  -- gopls binary must be installed and located on PATH.
  'gopls',
  -- [https://github.com/eclipse-jdtls/eclipse.jdt.ls] needs to be installed
  -- and the jdtls binary located in
  -- org.eclipse.jdt.ls.product/target/repository/bin must be located on PATH.
  'jdtls',
  -- [https://github.com/luals/lua-language-server] needs to be installed
  -- and the lua-langauge-server binary must be located on PATH.
  -- NOTE: On Windows on ARM, lua-language-server needs to be patched to be
  -- built successfully.
  'lua_ls',
  -- rust-analyzer must be installed and located on PATH.
  -- On projects that use a specific rust toolchain
  -- (specified using rust-toolchain.toml), the correct version of the
  -- Rust toolchain must be installed as specified in rust-toolchain.toml.
  -- Otherwise, the LSP does not work correctly and throws errors.
  'rust_analyzer',
  -- [https://github.com/kristoff-it/superhtml.git] binary needs to be
  -- installed and located on PATH.
  'superhtml',
  -- [https://github.com/tailwindlabs/tailwindcss-intellisense]
  -- The binary can be installed globally using npm via:
  -- npm install -g @tailwindcss/language-server
  -- NOTE: Not having the language-server globally installed and enabling
  -- the language server results in errors being reported in Neovim
  -- during :checkhealth and :checkhealth vim.lsp.
  -- Hence, it is highly recommended to have it installed globally.
  'tailwindcss',
  -- [https://github.com/yioneko/vtsls]
  -- The binary can be installed globally using npm via:
  -- npm install -g @vtsls/language-server
  -- NOTE: Not having the language-server globally installed and enabling
  -- the language server results in errors being reported in Neovim
  -- during :checkhealth and :checkhealth vim.lsp.
  -- Hence, it is highly recommended to have it installed globally.
  'vtsls',
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

if vim.fn.executable('lua-language-server') ~= 1 then
  vim.schedule(function()
    vim.notify(
      'Lua LSP could not be started: lua-language-server not found in PATH.',
      vim.log.levels.WARN,
      { title = 'Lua LSP' }
    )
  end)
  return {}
end

return {
  -- Command to start the server
  cmd = { 'lua-language-server' },
  -- Filetypes to automatically attach to
  filetypes = { 'lua' },
  -- Sets the workspace to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        -- This makes the server aware of Neovim runtime files
        -- This operation is very slow as it indexes all core
        -- Neovim files as well as every plugin file and the files
        -- in the Neovim configuration folder.
        -- TODO: Find a better way to make LSP aware of neovim lua API.
        library = vim.api.nvim_get_runtime_file('lua', true),
        checkThirdParty = false,
      },
    }
  }
}

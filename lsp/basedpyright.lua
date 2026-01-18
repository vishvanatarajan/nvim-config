return {
  cmd = { 'basedpyright-langserver.exe', '--stdio' },
  -- the file type that the lsp server should attach to.
  filetypes = { 'python' },
  -- Identifying root directory
  root_markers = {
    'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt',
    'Pipfile', 'pyrightconfig.json', '.git'
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = 'recommended',
      },
    }
  },
  on_attach = function(client, bufnr)
    -- Disable formatting from BasedPyright
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Create autocmd for Ruff formatting on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('RuffFormatting', { clear = true }),
      buffer = bufnr,
      callback = function()
        local filepath = vim.api.nvim_buf_get_name(bufnr)
        vim.fn.jobstart({ 'ruff', 'format', filepath }, {
          on_exit = function()
            vim.cmd('edit!') -- reload buffer after formatting
          end,
        })
      end,
      desc = 'Format Python with Ruff on save',
    })
  end,
}

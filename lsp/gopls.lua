return {
  cmd = { 'gopls.exe' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true
    }
  },
  on_attach = function(client, bufnr)
    -- Configuration for Go files
    -- Use buffer-local options to set tab and indendation settings
    -- These settings only apply to Go files
    vim.bo.tabstop = 4 -- A tab character will be 4 spaces wide.
    vim.bo.shiftwidth = 4 -- Indentation will use 4 spaces.
    vim.bo.expandtab = true -- Converts tabs to spaces.

    -- Enable format on save
    if client and client.supports_method('textDocument/codeAction') then
      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        group = vim.api.nvim_create_augroup('GoFormatting', { clear = true }),
        buffer = bufnr,
        callback = function()
          -- Request `source.organizeImports` code action
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { 'source.organizeImports' } }

          -- Use a timeout for the sync request
          local result = vim.lsp.buf_request_sync(
            bufnr, 'textDocument/codeAction', params, 3000
          )

          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (
                  vim.lsp.get_client_by_id(cid) or {}
                ).offset_encoding or 'utf-16'
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end

          -- trigger general formatting
          vim.lsp.buf.format({ async = false, bufnr = bufnr })
        end
      })
    end
  end
}

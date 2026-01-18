require('config.helpers')

local tsserver_path = find_npm_binary('typescript-language-server')

if tsserver_path and tsserver_path ~= '' then
  return {
    cmd = { tsserver_path, '--stdio' },
    filetypes = {
      'javascript', 'javascriptreact',
      'typescript', 'typescriptreact'
    },
    root_dir = find_project_root(
      {
        'package.json',
        '.git',
        'tsconfig.json',
        'jsconfig.json'
      }
    ),
    on_attach = function()
      vim.bo.tabstop = 4 -- A tab character will be 4 spaces wide.
      vim.bo.shiftwidth = 4 -- Indentation will use 4 spaces.
      vim.bo.expandtab = true -- Converts tabs to spaces.
    end
  }
else
  return {}
end

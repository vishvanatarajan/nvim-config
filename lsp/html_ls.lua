require('config.helpers')

local html_ls_path = find_npm_binary('vscode-html-language-server')

if html_ls_path and html_ls_path ~= '' then
  return {
    cmd = { html_ls_path, '--stdio' },
    filetypes = { 'html' },
    root_dir = find_project_root(
      {
        'package.json',
        '.git',
        'index.html',
      }
    ),
    settings = {
      html = {
        format = {
          enable = true,
        },
        validate = {
          scripts = false,
          styles = false,
        },
      },
    },
  }
else
  return {}
end

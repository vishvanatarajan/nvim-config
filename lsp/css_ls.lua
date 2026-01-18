require('config.helpers')

local css_ls_path = find_npm_binary('vscode-css-language-server')

if css_ls_path and css_ls_path ~= '' then
  return {
    cmd = { css_ls_path, '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_dir = find_project_root(
      {
        'package.json',
        '.git'
      }
    ),
    settings = {
      css = {
        validate = {
          enable = true
        },
        format = {
          newlineBetweenRules = true,
          spaceAroundSelectorSeparator = true,
        },
        editor = {
          colorDecorators = true,
        },
        lint = {
          emptyRules = 'warning',
        },
      },
    },
  }
else
  return {}
end

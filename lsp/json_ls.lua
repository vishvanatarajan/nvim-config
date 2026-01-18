require('config.helpers')

local json_ls_path = find_npm_binary('vscode-json-language-server')

if json_ls_path and json_ls_path ~= '' then
  return {
    cmd = { json_ls_path, '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_dir = find_project_root(
      {
        'package.json',
        '.git',
        'tsconfig.json',
      }
    ),
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { 'package.json' },
            url = 'https://www.schemastore.org/package.json'
          },
          {
            fileMatch = { '.eslintrc', 'eslintrc.json' },
            url = 'https://www.schemastore.org/eslintrc.json'
          },
          {
            fileMatch = { 'tsconfig.json' },
            url = 'https://www.schemastore.org/tsconfig.json'
          },
          {
            fileMatch = { '.prettierrc', 'prettierrc.json' },
            url = 'https://www.schemastore.org/prettierrc.json'
          },
          {
            fileMatch = { 'jest.config.json' },
            url = 'https://www.schemastore.org/jest.json'
          },
          {
            fileMatch = { 'firebase.json' },
            url = 'https://raw.githubusercontent.com/firebase/firebase-tools/master/schema/firebase-config.json'
          },
          {
            fileMatch = { 'angular.json' },
            url = 'https://raw.githubusercontent.com/angular/angular-cli/master/packages/angular/cli/lib/config/workspace-schema.json'
          },
          {
            fileMatch = { '.babelrc', 'babel.config.json' },
            url = 'https://www.schemastore.org/babelrc.json'
          },
          {
            fileMatch = { 'composer.json' },
            url = 'https://getcomposer.org/schema.json'
          },
          {
            fileMatch = { 'docker-compose.yml' },
            url = 'https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json'
          },
        },
        validate = {
          enable = true,
        },
        format = {
          enable = true,
          keepLines = true,
        },
      },
    },
  }
else
  return {}
end

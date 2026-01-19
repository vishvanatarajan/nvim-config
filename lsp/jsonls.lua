require('config.helpers')

vim.lsp.config('jsonls', {
    cmd = { find_npm_binary('vscode-json-language-server'), '--stdio' },
})

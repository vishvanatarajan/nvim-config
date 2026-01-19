require('config.helpers')

vim.lsp.config('cssls', {
    cmd = { find_npm_binary('vscode-css-language-server'), '--stdio' },
})

require('config.helpers')

vim.lsp.config('html', {
    cmd = { find_npm_binary('vscode-html-language-server'), '--stdio' },
})

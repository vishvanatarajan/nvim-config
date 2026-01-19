require('config.helpers')

vim.lsp.config('ts_ls', {
    cmd = { find_npm_binary('typescript-language-server'), '--stdio' },
})

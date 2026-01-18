return {
  'nvim-treesitter/nvim-treesitter',
  -- This plugin does not support lazy loading
  lazy = false,
  -- Make sure to specify the main branch since (for now)
  -- the default branch is master
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter'.install { 
      'c', 'cmake', 'cpp', 'css', 'dockerfile', 'editorconfig',
      'elixir', 'erlang', 'gitignore', 'go', 'html', 'java', 'javadoc',
      'javascript', 'json', 'lua', 'markdown', 'php', 'powershell',
      'python', 'rust', 'scala', 'scss', 'sql', 'swift', 'typescript',
      'xml', 'yaml', 'zig'
    }
    vim.api.nvim_create_autocmd('FileType', {
      -- All installed language parsers that support highlighting
      -- must be listed below for highlighting to be active.
      pattern = {
        'c', 'cmake', 'cpp', 'css', 'dockerfile', 'editorconfig',
        'elixir', 'erlang', 'gitignore', 'go', 'html', 'java', 'javadoc',
        'javascript', 'json', 'lua', 'markdown', 'php', 'powershell',
        'python', 'rust', 'scala', 'scss', 'sql', 'swift', 'typescript',
        'xml', 'yaml', 'zig'
      },
      callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    })
  end
}

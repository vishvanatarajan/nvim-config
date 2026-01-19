-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git', 'clone',
    '--filter=blob:none', '--branch=stable',
    lazyrepo, lazypath 
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
if not vim.g.mapleader then
  vim.g.mapleader = ' '
  vim.schedule(function()
    vim.notify(
      'Vim leader not explicitly configured. ' ..
      'It has defaulted to: `' .. vim.g.mapleader .. '`.\n' ..
      'To set it, add `vim.g.mapleader` to your init.lua.\n\n',
      vim.log.levels.WARN
    )
  end)
end
if not vim.g.maplocalleader then
  vim.g.maplocalleader = '\\'
  vim.schedule(function()
    vim.notify(
      'Map local leader not explicitly configured. ' ..
      'It has defaulted to: `' .. vim.g.maplocalleader .. '`.\n' ..
      'To set it, add `vim.g.maplocalleader` to your init.lua.\n\n',
      vim.log.levels.WARN
    )
  end)
end

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    -- import your plugins
    { import = 'plugins' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'habamax' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

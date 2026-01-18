-- Vim options to be set are specified in this file
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- disable language provider support (lua and vimscript plugins only)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.autoread = true -- Enable auto read
opt.completeopt = 'menu,menuone,noselect'
-- Hide * markup for bold and italic, but not markers with substitution
opt.conceallevel = 2
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.foldlevel = 99
opt.ignorecase = true -- Ignore case
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...)
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.ruler = false -- Disable the default ruler
opt.scrolloff = 4 -- Lines of context
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- Dont show mode since we have a statusline
-- Always show the signcolumn, otherwise it would shift the text each time
opt.signcolumn = 'yes'
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen'
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 300 -- Save swap file and trigger CursorHold
-- Allow cursor to move where there is no text in visual block mode
opt.virtualedit = 'block'
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.wrap = false -- Disable line wrap
opt.winborder = 'rounded' -- Border style of floating windows

-- Define the specific 'Profiles' for each shell environment
local shell_configs = {
  powershell = {
    shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
    shellcmdflag = table.concat({
      '-NoLogo',
      '-NonInteractive',
      '-ExecutionPolicy RemoteSigned',
      '-Command [Console]::InputEncoding=[System.Text.UTF8Encoding]::new(); ' ..
        '[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new(); ' ..
        '$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\'; ' ..
        '$PSStyle.OutputRendering=\'plaintext\'; ' ..
        'Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    }, ' '),
    shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode',
    shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode',
    shellquote = '',
    shellxquote = '',
  },
  default = {
    shell = vim.o.shell, -- Keeps the system default (bash/zsh/sh)
    shellpipe = '| tee',
    shellredir = '>%s 2>&1',
  }
}

local is_powershell =
  vim.fn.executable('pwsh') == 1 or vim.fn.executable('powershell') == 1

-- Select the profile
local settings =
  is_powershell and shell_configs.powershell or shell_configs.default

-- Apply the settings
for option, value in pairs(settings) do
  opt[option] = value
end

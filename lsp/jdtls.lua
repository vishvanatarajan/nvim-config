local function get_jdtls_paths()
  local bin = vim.fn.exepath('jdtls')
  if bin == "" then return nil, nil end

  -- Find the config folder relative to the binary
  local real_path = vim.fn.resolve(bin)
  local root = vim.fs.dirname(vim.fs.dirname(real_path))
  
  -- Simple OS detection for the config folder name
  local os_config = 'config_linux'
  if vim.uv.os_uname().sysname == 'Windows_NT' then
    os_config = 'config_win'
  elseif vim.uv.os_uname().sysname == 'Darwin' then
    os_config = 'config_mac'
  end

  return bin, vim.fs.joinpath(root, os_config)
end

local jdtls_bin, jdtls_config_path = get_jdtls_paths()

vim.lsp.config('jdtls', {
  cmd = function(dispatchers, opts)
    opts = opts or {}
    local root_dir = opts.root_dir or vim.fn.getcwd()

    -- Minimum required command to start jdtls correctly
    local cmd = {
      jdtls_bin,
      '-configuration', jdtls_config_path,
      '-data', vim.fs.joinpath(
          vim.fn.stdpath('cache'), 'jdtls', 'workspace',
          vim.fn.fnamemodify(root_dir, ':p:h:t')
      ),
    }

    return vim.lsp.rpc.start(cmd, dispatchers, {
      cwd = root_dir,
    })
  end,
})

local function get_jdtls_paths()
  local bin = vim.fn.exepath('jdtls')
  if bin == "" then return nil, nil end

  -- 1. Find the root installation folder relative to the binary
  local real_path = vim.fn.resolve(bin)
  local root = vim.fs.dirname(vim.fs.dirname(real_path))

  -- 2. Detect OS and Architecture
  local sys = vim.uv.os_uname()
  local os_name = sys.sysname
  local arch = sys.machine:lower() -- e.g., "x86_64", "arm64", "aarch64"

  local os_config = 'config_linux' -- Default fallback

  if os_name == 'Windows_NT' then
    os_config = 'config_win'
  elseif os_name == 'Darwin' then
    -- Detect Apple Silicon vs Intel Mac
    if arch:match('arm') or arch:match('aarch64') then
      os_config = 'config_mac_arm'
    else
      os_config = 'config_mac'
    end
  elseif os_name == 'Linux' then
    -- Detect ARM Linux vs x86 Linux
    if arch:match('arm') or arch:match('aarch64') then
      os_config = 'config_linux_arm'
    else
      os_config = 'config_linux'
    end
  end

  return bin, vim.fs.joinpath(root, os_config)
end

local jdtls_bin, jdtls_config_path = get_jdtls_paths()

vim.lsp.config('jdtls', {
  cmd = function(dispatchers, opts)
    -- Defensive handling if server starts without root_dir context
    opts = opts or {}
    local root_dir = opts.root_dir or vim.fn.getcwd()

    -- Generate a unique workspace name based on project folder name
    local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
    local data_dir = vim.fs.joinpath(
      vim.fn.stdpath('cache'), 'jdtls', 'workspace', project_name
    )

    local cmd = {
      jdtls_bin,
      '-configuration', jdtls_config_path,
      '-data', data_dir
    }

    return vim.lsp.rpc.start(cmd, dispatchers, {
      cwd = root_dir,
    })
  end,
})

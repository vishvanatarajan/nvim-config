local function get_jdtls_config()
  local sys = vim.uv.os_uname()
  local os = sys.sysname
  local arch = sys.machine

  if os == 'Windows_NT' then
    return 'config_win' -- Windows usually uses the same config folder for both
  elseif os == 'Darwin' then
    return (arch:match('arm') or arch:match('aarch64'))
      and 'config_mac_arm' or 'config_mac'
  elseif os == 'Linux' then
    return (arch:match('arm') or arch:match('aarch64'))
      and 'config_linux_arm' or 'config_linux'
  else
    return 'config_linux' -- Default fallback
  end
end

-- Get the install path of JDTLS from an environment variable (JDTLS_HOME)
local jdtls_install = os.getenv('JDTLS_HOME')

-- Determine the OS-specific configuration folder
local os_config = get_jdtls_config()

-- Return an empty table if the JDTLS_HOME variable isn't set
if not jdtls_install then
  vim.schedule(function()
    vim.notify(
      'JDTLS_HOME environment variable not set. Java LSP will not start.',
      vim.log.levels.WARN,
      { title = 'Java LSP Config' }
    )
  end)
  return {}
end

-- Path to the repository target
local eclipse_jdt_ls_path = vim.fs.joinpath(
  jdtls_install,
  'org.eclipse.jdt.ls.product',
  'target',
  'repository'
)

return {
  cmd = {
    vim.fs.joinpath(eclipse_jdt_ls_path, 'bin', 'jdtls'),
    '-configuration', vim.fs.joinpath(eclipse_jdt_ls_path, os_config),
    '-data', vim.fs.joinpath(
      vim.fn.stdpath('data'),
      'jdtls-workspace',
      vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    ),
  },
  filetypes = { 'java', 'groovy' },
  root_dir = vim.fs.dirname(vim.fs.find({
    'gradlew', 'mvnw', 'pom.xml', 'build.gradle',
    'build.gradle.kts', 'settings.gradle', 'build.xml',
    '.git'
  }, { upward = true })[1]) or vim.fn.getcwd(),
  on_attach = function()
    vim.bo.tabstop = 4 -- A tab character will be 4 spaces wide.
    vim.bo.shiftwidth = 4 -- Indentation will use 4 spaces.
    vim.bo.expandtab = true -- Converts tabs to spaces.
  end
}

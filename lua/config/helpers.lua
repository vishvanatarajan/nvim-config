function find_npm_binary(name)
  -- Search for local binary inside node_modules
  local local_path = vim.fn.exepath('node_modules/.bin/' .. name)
  if local_path and local_path ~= '' and vim.fn.filereadable(local_path) then
    return local_path
  end

  -- Search for global binary
  local global_path = vim.fn.exepath(name)
  if global_path and global_path ~= '' and vim.fn.filereadable(global_path) then
    return global_path
  end

  return nil
end

function find_project_root(patterns)
  -- Search for the root file patterns upwards from the current directory
  local path = vim.fs.find(patterns, { upward = true })

  -- If a root file was found, return it's directory
  if path and #path > 0 then
    return vim.fs.dirname(path[1])
  end

  -- If no root file was found, fall back to the current working directory
  return vim.fn.getcwd()
end

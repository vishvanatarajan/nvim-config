return {
  cmd = { 'clangd.exe', '--background-index', '--clang-tidy' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp', 'cc', 'cxx', 'c++', 'h', 'hpp', 'hxx', 'h++' },
}

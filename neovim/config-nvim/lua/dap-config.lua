-- We're assuming debugpy package is installed with this python
require('dap-python').setup('python')

-- Add my Config

local python_configs = require('dap').configurations.python

table.insert(python_configs, {
  type = 'python';
  request = 'launch';
  name = 'Launch file with arguments';
  program = '${workspaceFolder}/${file}';
  args = function()
    local args_string = vim.fn.input('Arguments: ')
    local a = {}
    for arg in string.gmatch(args_string, "%S+") do
      table.insert(a, arg)
    end
    return a
  end;
  console = 'integratedTerminal';
})


vim.api.nvim_set_keymap('n', '<F5>', ":lua require('dap').continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>si', ":lua require('dap').step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>so', ":lua require('dap').step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ":lua require('dap').toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B', ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lp', ":lua require('dap')..set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', ":lua require('dap').repl.open()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ":lua require('dap').run_last()<CR>", { noremap = true, silent = true })

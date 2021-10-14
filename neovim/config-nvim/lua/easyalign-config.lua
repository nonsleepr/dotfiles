vim.g.easy_align_delimiters = {
  ['/'] = {
    pattern = '//\\+\\|/\\*\\|\\*/',
    delimiter_align = 'l',
    ignore_groups = {'!Comment'},
  },
  ['%'] = {
    pattern = '%\\+',
    delimiter_align = 'l',
  },
}

vim.api.nvim_set_keymap('x', '<Leader>a', ':LiveEasyAlign<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', ':LiveEasyAlign<CR>', { silent = true })

vim.g.NERDTreeQuitOnOpen = 1

vim.cmd [[
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
]]

vim.api.nvim_set_keymap('n', '<Leader>nt', ':NERDTree<CR>', { noremap = true, silent = true })


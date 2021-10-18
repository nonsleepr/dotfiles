local script_dir = vim.fn.expand('<sfile>:h')

require('plugins')
require('keymappings')
require('config')
vim.cmd('source '..script_dir..'/autocmd.vim')

require('vimwiki-config')
require('easyalign-config')
require('crease-config')
require('telescope-config')
require('treesitter-config')
require('lsp-config')
require('camelcase-config')
require('lualine-config')

--[[ Colorscheme ]]--
-- Should be executed last
vim.o.background = 'dark'
vim.o.termguicolors = true -- It messes things up for some reason making colors crazy
vim.g.colors_name = 'lush-solarized'


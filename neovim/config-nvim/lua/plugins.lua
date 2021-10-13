-- Bootstrap packer.nvim
-- See https://github.com/wbthomason/packer.nvim#bootstrapping
--
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  if vim.v.shell_error > 0 then
    print("Error installing packer.nvim:")
    print(packer_bootstrap)
  end
end

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
--vim._update_package_paths()


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'bkad/CamelCaseMotion'
  use 'junegunn/fzf.vim'
  use 'junegunn/fzf'
  use 'Vimjas/vim-python-pep8-indent'
  use 'junegunn/rainbow_parentheses.vim' -- TODO: See why it doesn't work
  use 'wellle/targets.vim'
  use 'mbbill/undotree'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-repeat'
  use 'derekwyatt/vim-scala'
  use 'tpope/vim-surround'
  use 'fatih/vim-go'
  use 'tweekmonster/braceless.vim'
  use 'rbong/vim-flog'
  use 'unblevable/quick-scope'
  use 'tpope/vim-rhubarb'
  --use 'vimwiki/vimwiki'
  --use 'tbabej/taskwiki'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'scr1pt0r/crease.vim' -- Nice folds
  use 'ishan9299/nvim-solarized-lua' -- Colorscheme

  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

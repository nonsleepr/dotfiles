-- Bootstrap packer.nvim
-- See https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  if vim.v.shell_error > 0 then
    print("Error installing packer.nvim:")
    print(packer_bootstrap)
  end
end

require('packer').startup({function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'bkad/CamelCaseMotion'
  --use 'junegunn/fzf.vim'
  --use 'junegunn/fzf'
  use 'Vimjas/vim-python-pep8-indent'
  use 'mbbill/undotree'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-fugitive'
  -- use 'airblade/vim-gitgutter'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup{
        current_line_blame = true,
      }
    end,
  }
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
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'scr1pt0r/crease.vim' -- Nice folds
  use {'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
  use 'lifepillar/vim-solarized8'
  use 'nonsleepr/lush-solarized.nvim'

  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use {
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    -- nvim-cmp doesn't support the use without the snippet engine
    -- (see https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings)
    requires = {'hrsh7th/vim-vsnip'}
  }
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'glepnir/lspsaga.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground', run = ':TSInstall query' }
  --use 'wellle/targets.vim'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'p00f/nvim-ts-rainbow'

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup{
        options = {
          theme = 'solarized',
        },
      }
    end
  }

  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end,
  }
}})

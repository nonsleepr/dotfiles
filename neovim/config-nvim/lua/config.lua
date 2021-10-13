vim.cmd('filetype plugin indent on')
vim.o.syntax = 'on'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.showmode = true
vim.o.showcmd = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ruler = true
vim.o.backspace = 'indent,eol,start'
vim.o.visualbell = true
vim.o.wrap = false
vim.o.compatible = false
-- Ignore whitespace comparison for vimdiff
vim.opt.diffopt:append('iwhite')
-- Allow non-saved buffers
vim.o.hidden = true
vim.o.wildmenu = true
vim.o.path = 'src/**' -- TODO: Instead of hardcoding, discover available dirs less ignored
vim.opt.wildignore:append('**/.git/**,**/project/project/**,**/target/**')

-- Always show statusline
vim.o.laststatus = 2
vim.g.scala_scaladoc_indent = 1
vim.g.netrw_list_hide = '.*\\.o$,.*\\.hi$,,.git/,.*\\.swp$'
vim.opt.mouse:append('a')

if string.find(vim.env.TERM, 'xterm') == 1 then
  vim.o.ttymouse = 'xterm2'
end

vim.o.tags = 'tags;/'
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2

vim.g.NERDTreeQuitOnOpen = 1
vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.o.gdefault = true -- applies substitutions globally
vim.o.incsearch = true
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.formatoptions = 'qrn1'
vim.o.textwidth = 79
vim.o.colorcolumn = '+1'

vim.cmd [[
highlight ColorColumn ctermbg=0
highlight LineNr ctermfg=grey ctermbg=0
highlight CursorLineNr ctermbg=0
]]

-- Rainbow parentheses
--[[
vim.g.rbpt_colorpairs = {
  { '13', '#6c71c4' },
  { '5',  '#d33682' },
  { '1',  '#dc322f' },
  { '9',  '#cb4b16' },
  { '3',  '#b58900' },
  { '2',  '#859900' },
  { '6',  '#2aa198' },
  { '4',  '#268bd2' },
}
vim.g.rbpt_max = 8
vim.g.rbpt_loadcmd_toggle = 0

-- let g:rainbow#max_level = 16
-- let g:rainbow#pairs = [['(', ')'], ['[', ']']]
--]]

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

-- via https://vimrcfu.com/snippet/179
vim.o.undofile     = true                         -- Save undo's after file closes
vim.o.undodir      = vim.fn.expand('~/.vim_undo') -- where to save undo histories
vim.o.undolevels   = 1000                         -- How many undos
vim.o.undoreload   = 10000                        -- number of lines to save for undo

-- Curly braces arguments
vim.g.targets_argOpening = '[({[]'
vim.g.targets_argClosing = '[]})]'

-- listchars - Highlight offending chars

if string.find(vim.o.enc, 'utf') == 1 then -- When running in a Unicode environment
  vim.o.list = true

  vim.opt.listchars:append('tab:▷⋅')
  vim.opt.listchars:append('trail:⋅')
  vim.opt.listchars:append('nbsp:⋅')
  vim.o.sbr = '↪ '
end

vim.o.signcolumn = 'yes'
-- vim.o.foldmethod = 'marker'

vim.g.vimspector_enable_mappings = 'HUMAN'

-- Autocommands

vim.cmd [[
autocmd BufEnter *.md :setlocal filetype=markdown

autocmd FileType gitcommit,gitrebase,gitconfig,taskedit set bufhidden=delete

autocmd FileType markdown :setlocal spell spelllang=en_us

autocmd FileType python BracelessEnable +indent +fold +highlight-cc
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8

autocmd StdinReadPre * let s:std_in=1

autocmd Syntax * RainbowParentheses
" autocmd Syntax * RainbowParenthesesLoadBraces
" autocmd Syntax * RainbowParenthesesLoadRound
" autocmd Syntax * RainbowParenthesesLoadSquare
" autocmd VimEnter * RainbowParenthesesToggle

" Enter terminal on open
autocmd TermOpen * startinsert

" via https://vimrcfu.com/snippet/186
" let terminal resize scale the internal windows
autocmd VimResized * :wincmd =

" Save on lost focus
"autocmd FocusLost * :wa

" Remove line numbers for inactive windows
"autocmd WinLeave,BufLeave * :set norelativenumber nonumber
"autocmd WinEnter,BufEnter * :set relativenumber number

" NERDTree
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
]]


-- VimWiki
vim.g.vimwiki_list = {{
  syntax = 'markdown',
  ext = '.md',
}}
vim.g.taskwiki_markup_syntax = 'markdown'

-- TODO: Port or remove that block
--[[
let g:tmuxcomplete#trigger = 'omnifunc'

" Shortcut to vertically split open file in ':' mode
:cnoreabbrev <expr> vsf ((getcmdtype() is# ':' && getcmdline() is# 'vsf')?('vert sf'):('vsf'))
--]]

-- CamelCaseMotion
vim.fn['camelcasemotion#CreateMotionMappings']('<Leader>')

-- Folds
vim.cmd [[
set fillchars=fold:━
let g:crease_foldtext = { 'default': '%f%f┫ %t%{CreaseChanged()} ┣%=┫ %l lines ┣%f%f' }

function! CreaseChanged()
    return gitgutter#fold#is_changed() ? ' *' : ''
endfunction
]]

-- LSP

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.o.completeopt = 'menu,menuone,noselect'

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },

    { name = 'buffer' },
  }
})

-- Setup lspconfig.
-- gopls Installed using the following command
--   GO111MODULE=on go get golang.org/x/tools/gopls@latest
require('lspconfig')['gopls'].setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Telescope
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    vimgrep_arguments = {
      'ag',
      '-i',
      '--vimgrep',
      '--noheading',
      '--hidden',
      '--smart-case',
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      theme = "dropdown",
    },
    git_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- Lualine
require('lualine').setup{
  options = {
    theme = 'solarized',
  },
}

-- Colorscheme
vim.o.background = 'dark'
vim.o.termguicolors = true -- It messes things up for some reason making colors crazy
vim.g.colors_name = 'solarized'


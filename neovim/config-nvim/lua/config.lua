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
vim.opt.mouse:append('a')

-- Not sure I need this anymore
--[[
if string.find(vim.env.TERM, 'xterm') == 1 then
  vim.o.ttymouse = 'xterm2'
end
]]--

vim.o.tags = 'tags;/'
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2

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

-- via https://vimrcfu.com/snippet/179
vim.o.undofile     = true                         -- Save undo's after file closes
vim.o.undodir      = vim.fn.expand('~/.vim_undo') -- where to save undo histories
vim.o.undolevels   = 1000                         -- How many undos
vim.o.undoreload   = 10000                        -- number of lines to save for undo

vim.o.shell = 'pwsh'

-- listchars - Highlight offending chars

if string.find(vim.o.enc, 'utf') == 1 then -- When running in a Unicode environment
  vim.o.list = true

  vim.opt.listchars:append('tab:▷⋅')
  vim.opt.listchars:append('trail:⋅')
  vim.opt.listchars:append('nbsp:⋅')
  vim.o.sbr = '↪ '
end

vim.o.signcolumn = 'yes'
-- TODO: Port or remove that block
--[[
let g:tmuxcomplete#trigger = 'omnifunc'

" Shortcut to vertically split open file in ':' mode
:cnoreabbrev <expr> vsf ((getcmdtype() is# ':' && getcmdline() is# 'vsf')?('vert sf'):('vsf'))
--]]

vim.g.scala_scaladoc_indent = 1
vim.g.netrw_list_hide = '.*\\.o$,.*\\.hi$,,.git/,.*\\.swp$'
-- Curly braces arguments
vim.g.targets_argOpening = '[({[]'
vim.g.targets_argClosing = '[]})]'

vim.g.vimspector_enable_mappings = 'HUMAN'


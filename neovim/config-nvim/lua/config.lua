vim.cmd('filetype plugin indent on')
vim.o.syntax = 'on'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
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
vim.o.foldmethod = 'marker'

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

-- see help for {shell-powershell}
vim.o.shell = 'pwsh'
vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellquote = ''
vim.o.shellxquote = ''

-- listchars - Highlight offending chars

if string.find(vim.o.enc, 'utf') == 1 then -- When running in a Unicode environment
  vim.o.list = true

  vim.opt.listchars:append('tab:▷⋅')
  vim.opt.listchars:append('trail:⋅')
  vim.opt.listchars:append('nbsp:⋅')
  vim.o.sbr = '↪ '
end

vim.o.inccommand = 'split'
vim.o.signcolumn = 'yes'


-- Substitute preview
vim.o.inccommand = 'split'

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

--[[ Patch fs_symlink to use junction which doesn't require admin rights on Windows ]]--
local orig_fs_symlink = vim.loop.fs_symlink
vim.loop.fs_symlink = function(path, new_path, flags, callback)
  if type(flags) == 'nil' then
    flags = {}
  end
  flags.junction = true
  return orig_fs_symlink(path, new_path, flags, callback)
end

-- Change the direction of new splits
-- via https://vimtricks.com/p/open-splits-more-naturally/
vim.o.splitbelow = true
vim.o.splitright = true

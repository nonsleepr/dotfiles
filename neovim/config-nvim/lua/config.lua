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
vim.o.undofile     = true               -- Save undo's after file closes
vim.o.undodir      = '$HOME/.vim_undo'  -- where to save undo histories
vim.o.undolevels   = 1000               -- How many undos
vim.o.undoreload   = 10000              -- number of lines to save for undo

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

autocmd Syntax * RainbowParenthesesLoadBraces
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare

autocmd VimEnter * RainbowParenthesesToggle

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

--[[
let g:tmuxcomplete#trigger = 'omnifunc'
--]]

--[[
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

-- Colorscheme
vim.o.background = 'dark'
vim.o.termguicolors = true -- It messes things up for some reason making colors crazy
vim.g.colors_name = 'solarized'


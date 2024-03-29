-- Indent hash-commented lines on >>
-- See https://stackoverflow.com/a/9982977
-- TODO: Maybe only do it when editing Python?
vim.api.nvim_set_keymap('i', '#', 'X<BS>#', { noremap = true, silent = true })

-- Disable Ctrl-Z (suspend) on Windows
if vim.fn.has('win32') > 0 then
  vim.api.nvim_set_keymap('n', '<C-Z>', '<Nop>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<C-Z>', '<Nop>', { noremap = true, silent = true })
end

-- Space as Leader
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- Ctrl+Backspace as Ctrl+W
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader><Space>', ':noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Tab>', '%', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Tab>', '%', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader><Leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })

-- C-h,j,k,l navigation for windows
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W>l', { noremap = true, silent = true })
-- This might be helpful:
-- vim.api.nvim_win_get_position(vim.api.nvim_get_current_win())[2]

-- Scala arrows (Hold shift when entering)
-- TODO: Maybe only do it when editing Scala?
vim.api.nvim_set_keymap('i', '+>', '<C-R>=nr2char(8658)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '_>', '<C-R>=nr2char(8594)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<_', '<C-R>=nr2char(8592)<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-N>', { noremap = true, silent = true })
-- Paste in terminal mode
--vim.api.nvim_set_keymap('t', '<C-R><C-R>', '<C-\\><C-N>"???pi', { noremap = true, silent = true, expr = true })
-- Works except for = register (expression)
vim.cmd [[ tnoremap <expr> <C-R><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi' ]]

-- Clear the screen in terminal mode
vim.api.nvim_set_keymap('t', '<C-L>', '<C-\\><C-N>:set scrollback=1<CR>i<C-L><C-\\><C-N>:set scrollback=10000<CR>i', { noremap = true, silent = true })

-- TODO: Translate the block below
--[[
" Stolen from fzf-vim
function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction

function! s:deleted_files()
  let lines = []
  let git_root = s:get_git_root()
  let git_log = split(system('git log --all --name-status --format=%P --diff-filter=DR'), "\n")
  let sha = ""
  for line in git_log
    if line =~ '^[0-9a-f]\{40}$'
      let sha = line
    elseif line =~ '.\+'
      let tokens = split(line)
      call add(lines, 'fugitive://'.git_root.'/.git//'.sha.'/'.tokens[1])
    endif
  endfor
  return lines
endfunction

command! GDFiles call fzf#run(fzf#wrap('gdfiles', {
      \ 'source': s:deleted_files(),
      \ 'options': ['--reverse', '-d', '/.git//[0-9a-f]{40}/', '--with-nth', '-1',
      \   '--inline-info', '--prompt', 'Deleted files> ']}))

nnoremap <Leader>d :GDFiles<CR>
--]]
vim.api.nvim_set_keymap('n', '<Leader>pi', ':PackerInstall<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>pu', ':PackerUpdate<CR>', { noremap = true, silent = true })


-- Allow `gf` to edit non-existent files
vim.api.nvim_set_keymap('n', 'gf', ':edit <cfile><CR>', { noremap = true, silent = true })

--[[ Permanently highlight selection
-- Inspired by https://vimtricks.com/p/highlight-specific-lines/
--]]
function _G.n_highlight()
  vim.fn.matchaddpos('VisualNOS', {vim.fn.line('.')})
end

function _G.v_highlight()
  local mode = vim.fn.visualmode()
  local pattern
  if     mode == 'v' then
    local _, line_start, col_start = unpack(vim.fn.getpos("'<"))
    local _, line_end, col_end = unpack(vim.fn.getpos("'>"))
    pattern = '\\%' .. line_start .. 'l\\%' .. col_start .. 'c\\_.*\\%' .. line_end .. 'l\\%' .. (col_end + 1) .. 'c'
  elseif mode == 'V' then
    local line_start = vim.fn.getpos("'<")[2]
    local line_end = vim.fn.getpos("'>")[2]
    pattern = '\\%' .. line_start .. 'l\\_.*\\%' .. line_end .. 'l'
  elseif mode == '\x16' then -- C-V
    local _, line_start, col_start = unpack(vim.fn.getpos("'<"))
    local _, line_end, col_end = unpack(vim.fn.getpos("'>"))
    pattern = '\\%>' .. (line_start - 1) .. 'l\\%<' .. (line_end + 1) .. 'l\\%' .. col_start .. 'c.*\\%' .. (col_end + 1) .. 'c'
  end
  vim.fn.matchadd('VisualNOS', pattern)
  print(pattern)
end

vim.api.nvim_set_keymap('n', '<Leader>hl', ':lua _G.n_highlight()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>hl', ':lua _G.v_highlight()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>hc', ':call clearmatches()<CR>', { noremap = true, silent = true })

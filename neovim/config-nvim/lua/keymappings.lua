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

-- Update tags
vim.api.nvim_set_keymap('n', '<Leader>ts', '!ctags -R src/ --exclude=target<CR>:redraw!<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>nt', ':NERDTree<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Tab>', '%', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Tab>', '%', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<Leader>a', ':LiveEasyAlign<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', ':LiveEasyAlign<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader><Leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>u', ':GitGutterUndoHunk<CR>', { noremap = true, silent = true })

-- C-h,j,k,l navigation for windows
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W>l', { noremap = true, silent = true })

-- Scala arrows (Hold shift when entering)
-- TODO: Maybe only do it when editing Scala?
vim.api.nvim_set_keymap('i', '+>', '<C-R>=nr2char(8658)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '_>', '<C-R>=nr2char(8594)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<_', '<C-R>=nr2char(8592)<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>af', ":Telescope find_files<CR>", { noremap = true, silent = true }) -- all files
vim.api.nvim_set_keymap('n', '<Leader>f', ":Telescope git_files<CR>", { noremap = true, silent = true }) -- git files
vim.api.nvim_set_keymap('n', '<Leader>g', ":Telescope live_grep<CR>", { noremap = true, silent = true })
-- TODO: Configure Telescope
-- nnoremap <Leader>g :lua require'telescope.builtin'.live_grep{ vimgrep_arguments = {'ag', '-i', '--vimgrep', '--noheading', '--hidden', '--smart-case'} }<cr>

vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-N>', { noremap = true, silent = true })

-- TODO: Translate the block below
--[[
" Paste in terminal mode
" Works except for = register (expression)
tnoremap <expr> <C-R><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Move between windows in terminal mode
":tnoremap <C-h> <C-\><C-N><C-w>h
":tnoremap <C-j> <C-\><C-N><C-w>j
":tnoremap <C-k> <C-\><C-N><C-w>k
":tnoremap <C-l> <C-\><C-N><C-w>l

Clear the screen in terminal mode
.api.nvim_set_keymap('t', '<C-L>', '<C-\\><C-N>:set scrollback=1<CR>i<C-L><C-\\><C-N>:set scrollback=10000<CR>i', { noremap = true, silent = true })

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

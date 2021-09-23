lua << EOF
if vim.fn.has('win32') then
  vim.g.my_vimrc = '~\\_vimrc'
  vim.g.my_vimfiles = '~\\vimfiles'
else
  vim.g.my_vimrc = '~/.vimrc'
  vim.g.my_vimfiles = '~/.vim'
end

vim.opt.runtimepath:prepend(vim.g.my_vimfiles)
vim.opt.runtimepath:append(vim.g.my_vimfiles..'/after')

vim.o.packpath = vim.o.runtimepath
vim.cmd ('source '..vim.g.my_vimrc)
EOF

nnoremap <Leader>f :Telescope find_files<CR>
nnoremap <Leader>g :lua require'telescope.builtin'.live_grep{ vimgrep_arguments = {'ag', '-i', '--vimgrep', '--noheading', '--hidden', '--smart-case'} }<cr>

tnoremap <Esc><Esc> <C-\><C-N>

" Paste in terminal mode
" Works except for = register (expression)
tnoremap <expr> <C-R><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Enter terminal on open
autocmd TermOpen * startinsert

" Move between windows in terminal mode
":tnoremap <C-h> <C-\><C-N><C-w>h
":tnoremap <C-j> <C-\><C-N><C-w>j
":tnoremap <C-k> <C-\><C-N><C-w>k
":tnoremap <C-l> <C-\><C-N><C-w>l

" Clear the screen in terminal mode
tnoremap <C-L> <C-\><C-N>:set scrollback=1<CR>i<C-l><C-\><C-N>:set scrollback=10000<CR>i

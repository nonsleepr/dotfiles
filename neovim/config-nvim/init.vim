set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

tnoremap <Esc><Esc> <C-\><C-N>

" Paste in terminal mode
" Works except for = register (expression)
tnoremap <expr> <C-R><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

let g:python3_host_prog = expand('~/venvs/neovim/bin/python')

" Enter terminal on open
autocmd TermOpen * startinsert

" Clear the screen in terminal mode
tnoremap <C-L> <C-\><C-N>:set scrollback=1<CR>i<C-l><C-\><C-N>:set scrollback=10000<CR>i

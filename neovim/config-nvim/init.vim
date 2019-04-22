set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

tnoremap <Esc><Esc> <C-\><C-N>

" Paste in terminal mode
tnoremap <expr> <C-R><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

let g:python3_host_prog = expand('~/venvs/neovim/bin/python')

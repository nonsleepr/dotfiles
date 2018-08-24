set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

tnoremap <Esc><Esc> <C-\><C-N>

" Paste in terminal mode
tnoremap <expr> <C-R><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

let g:python3_host_prog = expand('~/neovim-py3-venv/bin/python')

" via http://eed3si9n.com/sbt-server-with-neovim
set signcolumn=yes

let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'scala': ['node', expand('$ZSH/scala/sbt-server-stdio.js')]
    \ }

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

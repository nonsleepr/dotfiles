set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

tnoremap <Esc><Esc> <C-\><C-N>

" Paste in terminal mode
tnoremap <expr> <C-R><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

let g:python3_host_prog = expand('~/venvs/neovim/bin/python')

" via http://eed3si9n.com/sbt-server-with-neovim
set signcolumn=yes

" Language Client
let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'python': ['~/venvs/pyls/bin/pyls'],
    \ 'scala': ['node', expand('$DOTFILES/scala/sbt-server-stdio.js')]
    \ }

" let g:LanguageClient_loggingLevel = 'DEBUG'
" let g:LanguageClient_loggingFile =  expand('~/LanguageClient.log')
" let g:LanguageClient_serverStderr = expand('~/LanguageServer.log')

autocmd FileType python :LanguageClientStart<CR>

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

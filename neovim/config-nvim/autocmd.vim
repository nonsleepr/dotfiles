autocmd BufEnter *.md :setlocal filetype=markdown

autocmd FileType gitcommit,gitrebase,gitconfig,taskedit set bufhidden=delete

autocmd FileType markdown :setlocal spell spelllang=en_us

autocmd FileType python BracelessEnable +indent +fold +highlight-cc
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8

autocmd StdinReadPre * let s:std_in=1

" Enter terminal on open
autocmd TermOpen * startinsert

" via https://vimrcfu.com/snippet/186
" let terminal resize scale the internal windows
autocmd VimResized * :wincmd =

" Save on lost focus
"autocmd FocusLost * :wa

" Remove line numbers for inactive windows
"autocmd WinLeave,BufLeave * :set norelativenumber nonumber
"autocmd WinEnter,BufEnter * :set relativenumber number

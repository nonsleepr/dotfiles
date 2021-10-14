-- Folds
vim.cmd [[
set fillchars=fold:━
let g:crease_foldtext = { 'default': '%f%f┫ %t%{CreaseChanged()} ┣%=┫ %l lines ┣%f%f' }

function! CreaseChanged()
    return gitgutter#fold#is_changed() ? ' *' : ''
endfunction
]]



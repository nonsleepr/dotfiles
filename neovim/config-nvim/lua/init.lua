if vim.fn.has('win32') > 0 then
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

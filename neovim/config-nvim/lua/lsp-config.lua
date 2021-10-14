-- Setup lspconfig.
-- gopls Installed using the following command
--   GO111MODULE=on go get golang.org/x/tools/gopls@latest
require('lspconfig')['gopls'].setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

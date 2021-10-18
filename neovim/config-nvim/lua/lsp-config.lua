local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },

    { name = 'buffer' },
  }
})

-- Add additional capabilities supported by nvim-cmp
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.o.completeopt = 'menu,menuone,noselect'

-- gopls Installed using the following command
--   GO111MODULE=on go get golang.org/x/tools/gopls@latest
require('lspconfig')['gopls'].setup {
  capabilities = capabilities,
}

-- Install tsserver with the following command:
--   npm install -g typescript typescript-language-server
require('lspconfig')['tsserver'].setup {
  capabilities = capabilities,
}

-- Install pylsp with the following command:
--   pip install 'python-lsp-server[all]'
require('lspconfig')['pylsp'].setup {
  capabilities = capabilities,
}

return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        local lspconfig = require("lspconfig")
        local language_servers = lspconfig.util.available_servers()
        for _, ls in ipairs(language_servers) do
            lspconfig[ls].setup({
                capabilities = capabilities
            })
        end
        require("ufo").setup()
    end
}

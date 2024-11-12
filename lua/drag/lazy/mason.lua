return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "eslint",
                "rust_analyzer",
                "svelte",
                "pyright",
                "clangd",
                "lua_ls",
                "tinymist",
                "ts_ls",
                "denols",
                "clangd",
            },
            handlers = {
                function(server)
                    require("lspconfig")[server].setup({
                        capabilities = capabilities,
                    })
                end,
                clangd = function()
                    require("lspconfig").clangd.setup({
                        capabilities = capabilities,
                        settings = {
                            CPP = {
                                cmd = { "clangd", "-style=file:~/.clang-format" }
                            }
                        }
                    })
                end,
                denols = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.denols.setup({
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
                    })
                end,
                lua_ls = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    })
                end,
                tinymist = function()
                    require("lspconfig").tinymist.setup({
                        capabilities = capabilities,
                        single_file_mode = false,
                        root_dir = function(_, _) return vim.fn.getcwd() end,
                        offset_encoding = "utf-8",
                        settings = {
                            formatterMode = "typstyle",
                            exportPdf = "onSave"
                        }
                    })
                end,
                ts_ls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ts_ls.setup({
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern("package.json"),
                        single_file_mode = false,
                    })
                end,
            }
        })

        require("ufo").setup({})
    end
}

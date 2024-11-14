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

        local function previewPdf()
            os.execute(vim.fn.expandcmd("evince %:r.pdf&"))
        end

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
                texlab = function()
                    require("lspconfig").texlab.setup({
                        capabilities = capabilities,
                    })
                    vim.api.nvim_create_autocmd("BufWritePost", {
                        pattern = { "*.tex" },
                        callback = function()
                            local ok, _, code = os.rename(".auxfiles/", ".auxfiles")
                            if not ok and code ~= 13 then
                                local made = os.execute("mkdir .auxfiles")
                                if not made ~= 0 then
                                    vim.notify("failed to make .auxfiles", vim.log.levels.ERROR)
                                    return
                                end
                            end

                            local basename = vim.fs.basename(vim.fn.expand("%"))
                            for i = 1, 2, 1 do
                                local compiled = os.execute(string.format(
                                    "pdflatex -output-directory=.auxfiles %s >> /dev/null", basename))
                                if compiled ~= 0 then
                                    vim.notify(string.format("failed to compile latex at iteration %d", i), vim.log.levels.ERROR)
                                    return
                                end
                            end

                            local filename = string.sub(basename, 1, string.find(basename, ".tex") - 1)
                            local moved = os.execute(string.format("mv .auxfiles/%s.pdf . 2> /dev/null", filename))
                            if moved ~= 0 then
                                vim.notify("failed to move pdf file", vim.log.levels.ERROR)
                            end
                        end
                    })
                    require("which-key").add({
                        { "<leader>v", previewPdf, desc = "Pre[v]iew" }
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
                    require("which-key").add({
                        { "<leader>v", previewPdf, desc = "Pre[v]iew" }
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

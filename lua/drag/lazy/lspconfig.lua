return {
    "neovim/nvim-lspconfig",
    config = function ()
        require("java")

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local opts = { buffer = bufnr, remap = false }

                require("which-key").add({
                    { "gd",         function() vim.lsp.buf.definition() end,    opts,                                        desc = "[G]o to [d]efinition" },
                    { "gh",         function() vim.lsp.buf.hover() end,         opts,                                        desc = "[G]o [h]over" },
                    { "gs",         function() vim.diagnostic.open_float() end, opts,                                        desc = "[G]o [s]quiggle" },
                    { "g[d",        function() vim.diagnostic.goto_next() end,  opts,                                        desc = "[G]o to next" },
                    { "g]d",        function() vim.diagnostic.goto_prev() end,  opts,                                        desc = "[G]o to prev" },
                    { "gq",         function() vim.lsp.buf.code_action() end,   opts,                                        desc = "[G]o to [q]uick actions" },
                    { "gr",         function() vim.lsp.buf.references() end,    opts,                                        desc = "[G]o to [r]eferences" },
                    { "<leader>rr", function() vim.lsp.buf.rename() end,        opts,                                        desc = "[R]ename" },
                    { mode = "i",   "<C-h>",                                    function() vim.lsp.buf.signature_help() end, opts },
                })

                -- not quite sure what this does, if I ever figure it out, I'll actually use it lol
                -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            end,
        })
    end
}

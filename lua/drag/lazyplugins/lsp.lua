return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        -- LSP Support
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        -- Autocompletion
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        -- Snippets
        {
            "L3MON4D3/LuaSnip",
            version = "v2.1.1",
            build = "make install_jsregexp"
        },
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local lsp_zero = require("lsp-zero")

        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            })
        })

        lsp_zero.set_preferences({ sign_icons = {} })

        lsp_zero.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "gs", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "g[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "g]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "gq", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

            vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)

            -- not quite sure what this does, if I ever figure it out, I'll actually use it lol
            -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        end)

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "tsserver",
                "eslint",
                "rust_analyzer",
                "svelte",
                "pylsp",
                "clangd",
                "lua_ls",
            },
            handlers = { lsp_zero.default_setup }
        })
    end
}

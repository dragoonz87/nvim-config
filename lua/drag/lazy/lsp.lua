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
            build = "make install_jsregexp"
        },
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        require("neodev").setup({})

        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        lspconfig.clangd.setup({
            settings = {
                CPP = {
                    cmd = { "clangd", "-style=file:~/.clang-format" }
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

        local ls = require("luasnip")
        vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

        vim.keymap.set({"i", "s"}, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true})

        lsp_zero.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }
            local wk = require("which-key")

            wk.register({
                d = "[G]o to [d]efinition",
                h = "[G]o [h]over",
                s = "[G]o [s]quiggle",
                ["[d"] = "[G]o to next",
                ["]d"] = "[G]o to prev",
                q = "[G]o to [q]uick actions",
                r = "[G]o to [r]eferences"
            }, { prefix = "g" })
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "gs", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "g[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "g]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "gq", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)

            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

            vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)
            wk.register({
                r = {
                    r = "[R]ename"
                }
            }, { prefix = "<leader>" })

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
                "pyright",
                "clangd",
                "lua_ls",
            },
            handlers = { lsp_zero.default_setup }
        })
    end
}

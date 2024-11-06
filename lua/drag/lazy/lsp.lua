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
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets", },
            lazy = false
        },
        -- "rafamadriz/friendly-snippets",
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        require("neodev").setup({})
        require("java").setup()

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

        lspconfig.denols.setup({
            -- root_dir = function(filename, _)
            --     local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename)
            --     if denoRootDir then
            --         return denoRootDir
            --     else
            --         return nil
            --     end
            -- end,
            -- filetypes = { "typescript" }
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
        })

        lspconfig.ts_ls.setup({
            root_dir = function(filename, _)
                local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.json")(filename);
                if denoRootDir then
                    -- print('this seems to be a deno project; returning nil so that tsserver does not attach');
                    return nil;
                    -- else
                    -- print('this seems to be a ts project; return root dir based on package.json')
                end

                return lspconfig.util.root_pattern("package.json")(filename);
            end,
            single_file_support = false
        })

        lspconfig.typst_lsp.setup({
            settings = {
                exportPdf = "onSave"
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

        require("luasnip.loaders.from_vscode").lazy_load()

        local wk = require("which-key")
        local silent = { silent = true }
        wk.add({
            { mode = "i", "<C-K>", function() ls.expand() end, silent },
            {
                mode = { "i", "s" },
                {
                    { "<C-L>", function() ls.jump(1) end,  silent },
                    { "<C-J>", function() ls.jump(-1) end, silent },

                    { "<C-E>", function()
                        if ls.choice_active() then
                            ls.change_choice(1)
                        end
                    end, silent
                    } }
            }
        })

        lsp_zero.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

            wk.add({
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
        end)

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
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

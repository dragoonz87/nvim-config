return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp"
        },
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local ls = require("luasnip")
        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    ls.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-b>"] = cmp.mapping.scroll_docs(-1),
                ["<C-f>"] = cmp.mapping.scroll_docs(1),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "lazydev", group_index = 0 },
            })
        })

        local silent = { silent = true }
        require("which-key").add({
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
                    }
                }
            }
        })
    end
}

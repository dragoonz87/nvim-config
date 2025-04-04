return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    event = "LspAttach",
    config = function()
        local saga = require("lspsaga")
        local quit_key = { quit = "<C-c>" }

        local hover = function() require("lspsaga.hover"):render_hover_doc() end
        local peek_def = function() require("lspsaga.definition"):init(1, 1) end
        local codeaction = function() require("lspsaga.codeaction"):code_action() end
        local reference = function() require("lspsaga.finder"):new({}) end
        local implementations = function() require("lspsaga.finder"):new({ "imp" }) end
        local outline = function() require("lspsaga.symbol"):outline() end
        local rename = function() require("lspsaga.rename"):lsp_rename() end

        local function quit_and(table)
            return vim.tbl_deep_extend("force", quit_key, table)
        end

        saga.setup({
            code_action = {
                keys = quit_key
            },
            definition = {
                keys = quit_and({
                    edit = "<CR>"
                })
            },
            hover = {
                keys = quit_key
            },
            finder = {
                keys = quit_and({
                    toggle_or_open = "<CR>"
                })
            },
            outline = {
                layout = "float",
                keys = quit_and({
                    jump = "<CR>"
                })
            },
            rename = {
                keys = quit_key
            }
        })

        require("which-key").add({
            { "gh",         hover,           desc = "[G]o to [h]over" },
            { "gq",         codeaction,      desc = "[G]o to [q]uick actions" },
            { "gpd",        peek_def,        desc = "[G]o [p]eek [d]efinitions" },
            { "gr",         reference,       desc = "[G]o to [r]eferences" },
            { "gi",         implementations, desc = "[G]o to [i]mplementations" },
            { "go",         outline,         desc = "[G]o to [o]utline" },
            { "<leader>rr", rename,          desc = "[R]ename" },
        })
    end
}

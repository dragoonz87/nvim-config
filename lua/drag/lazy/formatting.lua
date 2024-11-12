return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                json = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
            }
        })

        require("which-key").add({
            { "<leader>f", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500
                })
            end,
            desc = "[F]ormat"
            }
        })
    end
}

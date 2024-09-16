return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.icons" },
    config = function()
        local oil = require("oil")
        local columns = {
            "icon"
        }

        oil.setup({
            default_file_explorer = true,
            columns = columns,
        })

        require("which-key").add({
            { "<leader>-", function() oil.open() end, desc = "Open parent directory" },
            {
                "<leader>os",
                function()
                    if #columns == 2 then
                        columns = {
                            "icon"
                        }
                    else
                        columns = {
                            "icon",
                            "size"
                        }
                    end

                    oil.set_columns(columns)
                end,
                desc = "[O]il show [s]ize"
            }
        })
    end
}

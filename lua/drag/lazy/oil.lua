return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local oil = require("oil")
        local columns = {
            "icon"
        }

        oil.setup({
            default_file_explorer = true,
            columns = columns,
        })

        require("which-key.keys").register({
            ["-"] = { function() oil.open() end, "Open parent directory" },
            o = {
                s = {
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
                    "[O]il show [s]ize"
                }
            }
        }, { prefix = "<leader>" })
    end
}

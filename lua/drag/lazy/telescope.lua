return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local builtin = require('telescope.builtin')
        require("which-key").register({
            s = {
                f = {
                    f = {
                        function()
                            builtin.find_files({})
                        end,
                        "[F]ind [f]ile"
                    },
                    g = {
                        function()
                            builtin.git_files({})
                        end,
                        "[F]ind [g]it files"
                    },
                },
                s = {
                    function()
                        builtin.grep_string({ search = vim.fn.input("Grep > "), })
                    end,
                    "[F]ind [s]tring"
                },
                g = {
                    function()
                        builtin.live_grep({})
                    end,
                    "[G]rep"
                }
            }
        }, { prefix = "<leader>" })
    end
}

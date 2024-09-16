return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local builtin = require('telescope.builtin')
        require("which-key").add({
            { "<leader>sff", function() builtin.find_files({}) end,                                     desc = "[F]ind [f]ile" },
            { "<leader>sfg", function() builtin.git_files({}) end,                                      desc = "[F]ind [g]it files" },
            { "<leader>ss",  function() builtin.grep_string({ search = vim.fn.input("Grep > "), }) end, desc = "[F]ind [s]tring" },
            { "<leader>sg",  function() builtin.live_grep({}) end,                                      desc = "[G]rep" }
        })
    end
}

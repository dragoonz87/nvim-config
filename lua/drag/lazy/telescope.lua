return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local ivy_theme = require("telescope.themes").get_ivy({})
        local builtin = require('telescope.builtin')
        require("which-key").add({
            { "<leader>sff", function() builtin.find_files(ivy_theme) end,                              desc = "[F]ind [f]ile" },
            { "<leader>sfg", function() builtin.git_files(ivy_theme) end,                               desc = "[F]ind [g]it files" },
            -- { "<leader>ss",  function() builtin.grep_string({ search = vim.fn.input("Grep > "), }) end, desc = "[F]ind [s]tring" },
            { "<leader>ss",  function() builtin.grep_string(ivy_theme) end, desc = "[F]ind [s]tring" },
            { "<leader>sg",  function() builtin.live_grep(ivy_theme) end,                               desc = "[G]rep" }
        })
    end
}

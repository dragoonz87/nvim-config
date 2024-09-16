return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            shell = "zsh",
        })

        require("which-key").add({
            { "<leader>t", vim.cmd.ToggleTerm, desc = "[T]erminal" }
        })
    end
}

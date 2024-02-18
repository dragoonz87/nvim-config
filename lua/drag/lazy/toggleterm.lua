return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            shell = "zsh",
        })

        require("which-key").register({
            t = { vim.cmd.ToggleTerm, "[T]erminal"}
        }, { prefix = "<leader>" })
    end
}

return {
    "tpope/vim-fugitive",
    config = function()
        require("which-key").add({
            { "<leader>gs", vim.cmd.Git, desc = "[G]it [s]tatus" }
        })
    end
}

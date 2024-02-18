return {
    "tpope/vim-fugitive",
    config = function()
        require("which-key").register({
            g = {
                s = { vim.cmd.Git, "[G]it [s]tatus" }
            }
        }, { prefix = "<leader>" })
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
}

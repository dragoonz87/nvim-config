return {
    "nvimdev/indentmini.nvim",
    event = "BufEnter",
    config = function()
        require("indentmini").setup({
            only_current = true
        })
    end
}

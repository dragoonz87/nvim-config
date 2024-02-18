return {
    "anuvyklack/fold-preview.nvim",
    config = function()
        local fold = require("fold-preview")
        fold.setup({
            default_keybindings = false,
            border = "rounded"
        })

        require("which-key").register({
            p = { function() fold.toggle_preview() end, "Preview fold" },
            o = "Open fold",
            c = "Close fold"
        }, { prefix = "z" })
    end
}

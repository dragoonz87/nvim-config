return {
    "anuvyklack/fold-preview.nvim",
    config = function()
        local fold = require("fold-preview")
        fold.setup({
            default_keybindings = false,
            border = "rounded"
        })

        require("which-key").add({
            { "zp", function() fold.toggle_preview() end, desc = "Preview fold" },
            { "zo",  desc = "Open fold" },
            { "zc",  desc = "Close fold" }
        })
    end
}

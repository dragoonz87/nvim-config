return {
    "chrisgrieser/nvim-recorder",
    opts = {},
    dependencies = { "rcarriga/nvim-notify" },
    config = function()
        require("recorder").setup({})
    end
}

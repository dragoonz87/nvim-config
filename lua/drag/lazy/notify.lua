return {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = require("notify")
        require("notify").setup({
            background_colour = "NotifyBackground",
            fps = 30,
            icons = {
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = ""
            },
            level = 2,
            max_height = 30,
            max_width = 100,
            minimum_width = 50,
            on_open = function() end,
            on_close = function() end,
            render = "compact",
            stages = "slide",
            time_formats = {
                notification = "%T",
                notification_history = "%FT%T"
            },
            timeout = 2500,
            top_down = true
        })
    end
}

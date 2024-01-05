return {
    "navarasu/onedark.nvim",
    name = "onedark",
    config = function()
        require("onedark").setup {
            style = "darker"
        }
        function ColorMyPencils(color)
            color = color or "onedark"
            vim.cmd.colorscheme(color)
        end

        ColorMyPencils()
    end
}

return {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    config = function ()
        vim.keymap.set("v", "<leader>mr", ":<C-u>MagmaEvaluateVisual<CR>")
        require("which-key").register({
            m = {
                i = { vim.cmd.MagmaInit, "[M]agma [i]nit" },
                r = {
                    r = { vim.cmd.MagmaEvaluateLine, "[M]agma [r]un Line" },
                    c = { vim.cmd.MagmaReevaluateCell, "[M]agma [r]un [c]ell" },
                },
                d = { vim.cmd.MagmaDelete, "[M]agma [d]elete cell" },
                o = { vim.cmd.MagmaShowOutput, "[M]agma show [o]utput" },
            }
        }, { prefix = "<leader>" })

        vim.g.magma_automatically_open_output = false
        vim.g.magma_image_provider = "kitty"
    end
}

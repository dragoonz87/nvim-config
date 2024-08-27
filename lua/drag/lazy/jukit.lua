return {
    "luk400/vim-jukit",
    config = function()
        vim.g.jukit_pdf_viewer = "evince"
        vim.api.nvim_create_autocmd("ColorScheme", {
            command = "highlight jukit_cellmarker_colors guifg=#1d615a guibg=#1d615a ctermbg=22 ctermfg=22"
        })

        local wk = require("which-key")

        wk.register({
            o = {
                s = { function() vim.api.nvim_call_function("jukit#splits#output", {}) end, "[J]ukit [o]utput [s]how" },
                c = { function() vim.api.nvim_call_function("jukit#splits#close_output_split", {}) end, "[J]ukit [o]utput [c]lear" },
                r = {
                    function()
                        vim.api.nvim_call_function("jukit#splits#close_output_split", {})
                        vim.api.nvim_call_function("jukit#splits#output", {})
                    end,
                    "[J]ukit [o]utput [r]estart"
                },
            },
            s = {
                c = { function() vim.api.nvim_call_function("jukit#send#section", { 0 }) end, "[J]ukit [s]end [c]ell" },
                s = { function() vim.api.nvim_call_function("jukit#send#line", {}) end, "[J]ukit [s]end line" },
                f = { function() vim.api.nvim_call_function("jukit#send#until_current_section", {}) end, "[J]ukit [s]end until current" },
                a = { function() vim.api.nvim_call_function("jukit#send#all", {}) end, "[J]ukit [s]end [a]ll" },
            },
            c = {
                j = { function() vim.api.nvim_call_function("jukit#cells#create_below", { 0 }) end, "[J]ukit [c]ell create below" },
                k = { function() vim.api.nvim_call_function("jukit#cells#create_above", { 0 }) end, "[J]ukit [c]ell create above" },
                d = { function() vim.api.nvim_call_function("jukit#cells#delete", {}) end, "[J]ukit [c]ell [d]elete" },
                s = { function() vim.api.nvim_call_function("jukit#cells#split", {}) end, "[J]ukit [c]ell [s]plit" },
                m = {
                    j = { function() vim.api.nvim_call_function("jukit#cells#merge_below", {}) end, "[J]ukit [c]ell [m]erge below" },
                    k = { function() vim.api.nvim_call_function("jukit#cells#merge_above", {}) end, "[J]ukit [c]ell [m]erge above" },
                },
            },
            m = {
                j = { function() vim.api.nvim_call_function("jukit#cells#create_below", { 1 }) end, "[J]ukit [m]arkdown create below" },
                k = { function() vim.api.nvim_call_function("jukit#cells#create_above", { 1 }) end, "[J]ukit [m]arkdown create above" },
            },
            n = {
                c = { function() vim.api.nvim_call_function("jukit#convert#notebook_convert", { "jupyter-notebook" }) end, "[J]ukit [n]otebook [c]onvert" },
                p = { function() vim.api.nvim_call_function("jukit#convert#save_nb_to_file", { 1, 1, "pdf" }) end, "[J]ukit [n]otebook export to [p]df" },
            },
            J = { function() vim.api.nvim_call_function("jukit#cells#move_down", {}) end, "[J]ukit move cell down" },
            K = { function() vim.api.nvim_call_function("jukit#cells#move_up", {}) end, "[J]ukit move cell up" },
            j = { function() vim.api.nvim_call_function("jukit#cells#jump_to_next_cell", {}) end, "[J]ukit go next cell" },
            k = { function() vim.api.nvim_call_function("jukit#cells#jump_to_previous_cell", {}) end, "[J]ukit go prev cell" },
            l = { function() vim.api.nvim_call_function("jukit#layouts#set_layout", {}) end, "[J]ukit reset [l]ayout" },
        }, { prefix = "<leader>j" })

        vim.keymap.set("v", "<leader>js", ":<C-U>call jukit#send#selection()<CR>")
        wk.register({
            s = "[J]ukit [s]end selection"
        }, { prefix = "<leader>j", mode = "v" })
    end
}

return {
    "luk400/vim-jukit",
    config = function()
        vim.g.jukit_pdf_viewer = "evince"
        vim.api.nvim_create_autocmd("ColorScheme", {
            command = "highlight jukit_cellmarker_colors guifg=#1d615a guibg=#1d615a ctermbg=22 ctermfg=22"
        })

        local wk = require("which-key")

        wk.add({
            { "<leader>jos", function() vim.api.nvim_call_function("jukit#splits#output", {}) end,             desc = "[J]ukit [o]utput [s]how" },
            { "<leader>joc", function() vim.api.nvim_call_function("jukit#splits#close_output_split", {}) end, desc = "[J]ukit [o]utput [c]lear" },
            {
                "<leader>jor",
                function()
                    vim.api.nvim_call_function("jukit#splits#close_output_split", {})
                    vim.api.nvim_call_function("jukit#splits#output", {})
                end,
                desc = "[J]ukit [o]utput [r]estart"
            },
            { "<leader>jsc",  function() vim.api.nvim_call_function("jukit#send#section", { 0 }) end,            desc = "[J]ukit [s]end [c]ell" },
            { "<leader>jss",  function() vim.api.nvim_call_function("jukit#send#line", {}) end,                  desc = "[J]ukit [s]end line" },
            { "<leader>jsf",  function() vim.api.nvim_call_function("jukit#send#until_current_section", {}) end, desc = "[J]ukit [s]end until current" },
            { "<leader>jsa",  function() vim.api.nvim_call_function("jukit#send#all", {}) end,                   desc = "[J]ukit [s]end [a]ll" },
            { "<leader>jcj",  function() vim.api.nvim_call_function("jukit#cells#create_below", { 0 }) end,      desc = "[J]ukit [c]ell create below" },
            { "<leader>jck",  function() vim.api.nvim_call_function("jukit#cells#create_above", { 0 }) end,      desc = "[J]ukit [c]ell create above" },
            { "<leader>jcd",  function() vim.api.nvim_call_function("jukit#cells#delete", {}) end,               desc = "[J]ukit [c]ell [d]elete" },
            { "<leader>jcs",  function() vim.api.nvim_call_function("jukit#cells#split", {}) end,                desc = "[J]ukit [c]ell [s]plit" },
            { "<leader>jcmj", function() vim.api.nvim_call_function("jukit#cells#merge_below", {}) end,          desc = "[J]ukit [c]ell [m]erge below" },
            { "<leader>jcmk", function() vim.api.nvim_call_function("jukit#cells#merge_above", {}) end,          desc = "[J]ukit [c]ell [m]erge above" },
            { "<leader>jmj",  function() vim.api.nvim_call_function("jukit#cells#create_below", { 1 }) end,      desc = "[J]ukit [m]arkdown create below" },
            { "<leader>jmk",  function() vim.api.nvim_call_function("jukit#cells#create_above", { 1 }) end,      desc = "[J]ukit [m]arkdown create above" },
            {
                "<leader>jnc",
                function()
                    vim.api.nvim_call_function("jukit#convert#notebook_convert",
                        { "jupyter-notebook" })
                end,
                desc = "[J]ukit [n]otebook [c]onvert"
            },
            { "<leader>jnp", function() vim.api.nvim_call_function("jukit#convert#save_nb_to_file", { 1, 1, "pdf" }) end, desc = "[J]ukit [n]otebook export to [p]df" },
            { "<leader>jJ",  function() vim.api.nvim_call_function("jukit#cells#move_down", {}) end,                      desc = "[J]ukit move cell down" },
            { "<leader>jK",  function() vim.api.nvim_call_function("jukit#cells#move_up", {}) end,                        desc = "[J]ukit move cell up" },
            { "<leader>jj",  function() vim.api.nvim_call_function("jukit#cells#jump_to_next_cell", {}) end,              desc = "[J]ukit go next cell" },
            { "<leader>jk",  function() vim.api.nvim_call_function("jukit#cells#jump_to_previous_cell", {}) end,          desc = "[J]ukit go prev cell" },
            { "<leader>jl",  function() vim.api.nvim_call_function("jukit#layouts#set_layout", {}) end,                   desc = "[J]ukit reset [l]ayout" },
            { mode = "v",    "<leader>js",                                                                                ":<C-U>call jukit#send#selection()<CR>",    desc = "[J]ukit [s]end selection" }
        })
    end
}

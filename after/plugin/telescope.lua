local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sff', builtin.find_files, {})
vim.keymap.set('n', '<leader>sfg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ss', function()
	builtin.grep_string({ search = vim.fn.input("Grep > "); })
end)
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"rust_analyzer",
	"svelte",
	"pylsp",
	"clangd",
    "lua_ls",
})

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
        diagnostics = {
            globals = { 'vim' }
        }
    }
  }
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({ sign_icons = {} })

lsp.setup_nvim_cmp({ mapping = cmp_mappings })

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "gs", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "g[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "g]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "gq", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

	vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)

    -- not quite sure what this does, if I ever figure it out, I'll actually use it lol
	-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
end)

lsp.setup()
